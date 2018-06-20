//
//  GoogleApiRequests.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 04.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import CoreLocation

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}


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
    static let shared = GoogleApiRequests()
    private init() {}
    
    
    func coordinatesToAddressRequest(with coordiantes: CLLocationCoordinate2D, completionHandler: @escaping (APIResult<RequestedCity>) -> ()) {
        let session = URLSession.shared
        let stringCoordinates = self.coordinatesToString(with: coordiantes)
        let request = GoogleAPIRequests.GeocodingAPI(coordinate: stringCoordinates).request
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(APIResult<RequestedCity>.Failure(error))
                }
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! JSON
                guard let city = RequestedCity(data: json) else {
                    DispatchQueue.main.async {
                        let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Couldn't define the curent city", comment: "")]
                        let error = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                        completionHandler(APIResult<RequestedCity>.Failure(error))
                    }
                    return
                }
                DispatchQueue.main.async {
                    completionHandler(APIResult<RequestedCity>.Success(city))
                }
            } catch {
                print("can't convert to JSON object!")
            }
        }
        task.resume()
    }
    
    
    
    func getRouteRequest(with startCoordinate: CLLocationCoordinate2D, and finishCoordinate: CLLocationCoordinate2D, completionHandler: @escaping (APIResult<RequestedRoute>) -> ()) {
        
        let session = URLSession.shared
        let startStringCoordinate = self.coordinatesToString(with: startCoordinate)
        let finishStringCoordinate = self.coordinatesToString(with: finishCoordinate)
        let request = GoogleAPIRequests.DirectionAPI(sourceCoordinate: startStringCoordinate, destCoordinate: finishStringCoordinate).request
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(APIResult<RequestedRoute>.Failure(error))
                }
                return 
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! JSON
                if let routeInfo = RequestedRoute(data: json) {
                    DispatchQueue.main.async {
                        completionHandler(APIResult<RequestedRoute>.Success(routeInfo))
                    }
                }
            } catch {
                print("can't convert to JSON object!")
            }
        }
        task.resume()
    }
    
    
    
    private func coordinatesToString(with coordinates: CLLocationCoordinate2D) -> String {
        let stringCoordinates = "\(coordinates.latitude)," + "\(coordinates.longitude)"
        return stringCoordinates
    }
    
    
}



