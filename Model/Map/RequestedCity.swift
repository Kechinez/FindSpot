//
//  File.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 11.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation

struct RequestedCity {
    let cityName: String
    
    init?(data: JSON) {
        guard let result = data["results"] as? [JSON] else { return nil }
        guard result.count != 0 else { return nil }
        guard let addressComponent = result[0]["address_components"] as? [JSON] else { return nil }
        guard let tempCityName = addressComponent[0]["long_name"] as? String else { return nil }
        self.cityName = tempCityName
    }

}
