//
//  DataBaseManager.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 05.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import Firebase

struct DataBaseManager {
    
    private let ref: DatabaseReference = Database.database().reference(withPath: "places")
    
    
    func getPlacesWithin(city: String, completionHandler: @escaping ([Place]?) -> ()) {

        let placesQuery = self.ref.queryOrdered(byChild: "city").queryEqual(toValue: city)
        
        placesQuery.observeSingleEvent(of: .value, with: { (data) in
            var placesArray: [Place]? = []
            let parsingDataQueue = DispatchQueue.global(qos: .userInitiated)
            parsingDataQueue.async {
                guard data.childrenCount != 0 else  {
                    DispatchQueue.main.async {
                        completionHandler(nil)
                    }
                    return
                }
                for child in data.children {
                    guard let foundPlace = child as? DataSnapshot else { return }
                    guard let obj = foundPlace.value as? JSON else { return }
                    if let tempPlace = Place(with: obj) {
                        placesArray!.append(tempPlace)
                    }
                }
                DispatchQueue.main.async {
                    completionHandler(placesArray)
                }
            }
        })
    }
        
   
 
    
    
}
