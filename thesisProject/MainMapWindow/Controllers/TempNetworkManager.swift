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
}
