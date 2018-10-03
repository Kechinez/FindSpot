//
//  Place.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 05.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import CoreLocation
typealias JSON = [String: AnyObject]

struct Place {
    let placeName: String
    let placeDescription: String
    let coordinates: CLLocationCoordinate2D
    let photosDownloadURLs: [URL]
    let city: String
    
    lazy var stringLatitude: String = {
        return "\(self.coordinates.latitude)"
    }()
    
    //MARK: - init
    init?(with data: JSON?) {
        guard let tempData = data else { return nil }
        guard let tempPlaceName = tempData["name"] as? String,
            let tempPlaceDescr = tempData["description"] as? String,
            let tempPlaceCoord = tempData["coordinates"] as? String,
            let tempCity = tempData["city"] as? String,
            let tempPlacePhotos = tempData["photos"] as? [String] else { return nil }
        
        let photosInit = { () -> [URL] in
            var tempPhotos = [URL]()
            for index in 0..<tempPlacePhotos.count {
                let photo = tempPlacePhotos[index]
                tempPhotos.append(URL(string: photo)!)
            }
            return tempPhotos
        }
        let coordinatesInit = { () -> CLLocationCoordinate2D in
            let stringCoordinates = tempPlaceCoord.components(separatedBy: ",")
            let latitude = Double(stringCoordinates[0])
            let longitude = Double(stringCoordinates[1])
            return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        }
        self.placeName = tempPlaceName
        self.placeDescription = tempPlaceDescr
        self.photosDownloadURLs = photosInit()
        self.city = tempCity
        self.coordinates = coordinatesInit()
    }
    
    
    init(placeName: String, placeDescription: String, photosDownloadURLs: [URL], cityName: String, coordinates: CLLocationCoordinate2D) {
        self.placeName = placeName
        self.placeDescription = placeDescription
        self.photosDownloadURLs = photosDownloadURLs
        self.city = cityName
        self.coordinates = coordinates
    }
    
    //MARK: supporting methods
    mutating func convertingToJSON() -> Any {
        var placeJSON = [String: Any]()
        var photosJSON = [String: String]()
        
        for (index, url) in self.photosDownloadURLs.enumerated(){
            photosJSON["\(index)"] = url.absoluteString
        }
        
        placeJSON = ["city": self.city, "name": self.placeName, "coordinates": "\(self.coordinates.latitude),\(self.coordinates.longitude)", "description": self.placeDescription, "photos": photosJSON]
        return placeJSON
    }
    
}
