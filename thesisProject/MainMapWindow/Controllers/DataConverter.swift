//
//  DataConverter.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 21.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation

struct DataConverter {
    var distance: String?
    var time: String?
    var polyline: String?
    
    init?(data: [String: AnyObject]) {
        
        guard let jsonRow = data["rows"] as? [[String: AnyObject]] else { return nil }
        
        guard let jsonElement = jsonRow[0]["elements"] as? [[String: AnyObject]] else { return nil }
        
        guard let jsonDistance = jsonElement[0]["distance"] as? [String: AnyObject],
            let jsonDuration = jsonElement[0]["duration"] as? [String: AnyObject] else { return nil }
        
        guard let tempDistance = jsonDistance["text"] as? String,
              let tempTime = jsonDuration["text"] as? String else { return nil }
        distance = tempDistance
        time = tempTime
        
        
    }

    init?(jsonArray: NSArray) {
        if let tempPolyline = jsonArray[0] as? [String: AnyObject] {
            if let dictPolyline = tempPolyline["overview_polyline"] as? [String: AnyObject] {
                if let stringPolyline = dictPolyline["points"] as? String{
                    polyline = stringPolyline
                }
            }
        } else {
            return nil
        }
    }
    
    
}
