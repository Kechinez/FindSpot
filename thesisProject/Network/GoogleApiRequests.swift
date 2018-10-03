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

//MARK: - API request builder
private enum GoogleAPIRequests {
    case GeocodingAPI(coordinate: String)
    case DirectionAPI(sourceCoordinate: String, destCoordinate: String)
    
    private var baseURL: URL? {
        return URL(string: "https://maps.googleapis.com/maps/api/")
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
    var request: URLRequest? {
        guard let url = URL(string: path, relativeTo: baseURL) else { return nil }
        return URLRequest(url: url)
    }
}

//MARK: - Network GoogleApiRequests
final class GoogleApiRequests {
    static let shared = GoogleApiRequests()
    private init() {}
    
    func getAddressFromCoordinates(_ coordiantes: CLLocationCoordinate2D, completionHandler: @escaping (APIResult<RequestedCity>) -> ()) {
        let session = URLSession.shared
        let stringCoordinates = self.createString(from: coordiantes)
        guard let request = GoogleAPIRequests.GeocodingAPI(coordinate: stringCoordinates).request else { return }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(APIResult<RequestedCity>.Failure(error!))
                }
                return
            }
            guard data != nil else {
                DispatchQueue.main.async {
                    completionHandler(APIResult<RequestedCity>.Failure(error!))
                }
                return
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
    
    func getRoute(from startCoordinate: CLLocationCoordinate2D, to finishCoordinate: CLLocationCoordinate2D, completionHandler: @escaping (APIResult<RequestedRoute>) -> ()) {
        
        let session = URLSession.shared
        let startStringCoordinate = self.createString(from: startCoordinate)
        let finishStringCoordinate = self.createString(from: finishCoordinate)
        guard let request = GoogleAPIRequests.DirectionAPI(sourceCoordinate: startStringCoordinate, destCoordinate: finishStringCoordinate).request else { return }
        
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
    
    private func createString(from coordinates: CLLocationCoordinate2D) -> String {
        let stringCoordinates = "\(coordinates.latitude)," + "\(coordinates.longitude)"
        return stringCoordinates
    }
}
