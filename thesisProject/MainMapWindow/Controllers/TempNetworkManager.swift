//
//  TempNetworkManager.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 21.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
class TempNetManager {
    private init() {}
    static let shared = TempNetManager()
    
    public func getData(url: URL, completionHandler: @escaping ([String: AnyObject]) -> ()) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            var httpResponse: HTTPURLResponse
            if let httpResponse1 = response as? HTTPURLResponse  {
                httpResponse = httpResponse1
            } else {
                print("3@@@@@@@@@@ ERROR @@@@@@@@@@@")
            }
            if data == nil {
                print("STATUS CODE OF HTTP IS") //\(httpResponse.statusCode)")
                return
            }
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                DispatchQueue.main.async {
                    completionHandler(json)
                }
            } catch {
                print("4@@@@@@@@@@ ERROR @@@@@@@@@@@")
            }
        }
        task.resume()
    }


    public func getRoutes(url: URL, completionHandler: @escaping (NSArray) -> ()) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if data == nil {
                print("ERROR!!!! Data is nil!!!")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                guard let route = json["routes"] as? NSArray else {
                    print("ERROR!!!! Can't get routes from JSON")
                    return
                }
                return completionHandler(route)
                
            } catch {
                print("")
            }
        }
        task.resume()
    }

        
        
        
        
}

/*
 if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
 
 guard let routes = json["routes"] as? NSArray else {
 DispatchQueue.main.async {
 self.activityIndicator.stopAnimating()
 }
 return
 }
 
 */








