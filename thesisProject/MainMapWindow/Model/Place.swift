//
//  Place.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 05.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import CoreLocation
typealias Coordinates = (latitude: Double, longitude: Double)
typealias JSON = [String: AnyObject]

struct Place {
    let placeName: String
    let placeDescription: String
    let coordinates: CLLocationCoordinate2D
    let photos: [String]
    let city: String
    
    init?(with data: JSON?) {
        guard let tempData = data else { return nil }
        guard let tempPlaceName = tempData["name"] as? String,
              let tempPlaceDescr = tempData["description"] as? String,
              let tempPlaceCoord = tempData["coordinates"] as? String,
              let tempCity = tempData["city"] as? String,
              let tempPlacePhotos = tempData["photos"] as? JSON else { return nil }
        
        let photosInit = { () -> [String] in
            var tempPhotos = [String]()
            for index in 1...tempPlacePhotos.count {
                guard let photo = tempPlacePhotos["photo\(index)"] as? String else { break }
                tempPhotos.append(photo)
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
        self.photos = photosInit()
        self.city = tempCity
        self.coordinates = coordinatesInit()
        
    }



}
