//
//  GoogleApiRequests.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 04.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import CoreLocation


private enum GoogleAPIRequests {
    case GeocodingAPI(coordinate: String)
    case DirectionAPI(sourceCoordinate: String, destCoordinate: String)

    private var baseURL: URL {
        return URL(string: "https://maps.googleapis.com/maps/api/")!
    }
    
    private var apiKey: String {
        return "AIzaSyAmV1T_J6_noWuMYBJukYv3-eDBvhr3zmY"
    }

    private var path: String {
        switch self {
        case GoogleAPIRequests.DirectionAPI(let sourceCoordinate, let destCoordinate):
            return "directions/json?origin=\(sourceCoordinate)&destination=\(destCoordinate)&mode=walking&language=en&key=\(apiKey)"
        case GoogleAPIRequests.GeocodingAPI(let coordinate):
            return "geocode/json?latlng=\(coordinate)&result_type=locality&language=en&key=\(apiKey)"
        }
    }

    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
}



class GoogleApiRequests {
//    static let shared = GoogleApiRequests()
//    private init() {}
    
    
    func coordinatesToAddressRequest(with coordiantes: CLLocationCoordinate2D, completionHandler: @escaping (RequestedCity?) -> ()) {
        let session = URLSession.shared
        let stringCoordinates = self.coordinatesToString(with: coordiantes)
        let request = GoogleAPIRequests.GeocodingAPI(coordinate: stringCoordinates).request
        
        let task = session.dataTask(with: request) { (data, response, error) in
        
            if data == nil {
                print("Error was occured")
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! JSON
                let city = RequestedCity(data: json)
                DispatchQueue.main.async {
                    completionHandler(city)
                }
            } catch {
                print("Pizdec")
            }
        }
        task.resume()
        
    }
        
    
    func getRouteRequest(with startCoordinate: CLLocationCoordinate2D, and finishCoordinate: CLLocationCoordinate2D, completionHandler: @escaping (RequestedRoute?) -> ()) {
        let session = URLSession.shared
        let startStringCoordinate = self.coordinatesToString(with: startCoordinate)
        let finishStringCoordinate = self.coordinatesToString(with: finishCoordinate)
        let request = GoogleAPIRequests.DirectionAPI(sourceCoordinate: startStringCoordinate, destCoordinate: finishStringCoordinate).request
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
           
            if data == nil {
                print("ERROR!!!! Data is nil!!!")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! JSON
//                guard let route = json["routes"] as? NSArray else {
//                    print("ERROR!!!! Can't get routes from JSON")
//                    return
//                }
                if let routeInfo = RequestedRoute(data: json) {
                    DispatchQueue.main.async {
                        completionHandler(routeInfo)
                    }
                }
            
                
            } catch {
                print("")
            }
        }
        task.resume()
    }
    
    
    
    private func coordinatesToString(with coordinates: CLLocationCoordinate2D) -> String {
        let stringCoordinates = "\(coordinates.latitude)," + "\(coordinates.longitude)"
        return stringCoordinates
    }
    

}



