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
                    guard let data = child as? DataSnapshot else { continue }
                    guard let foundPlace = data.value as? JSON else { continue }
                    if let tempPlace = Place(with: foundPlace) {
                        placesArray!.append(tempPlace)
                    }
                }
                DispatchQueue.main.async {
                    completionHandler(placesArray)
                }
            }
        })
    }
        
   
 
    func getUserFavorites(with dataBaseReference: DatabaseReference, completionHandler: @escaping ([Place]?) -> ()) {
        
        dataBaseReference.observe(.value) { (snapshot) in
            DispatchQueue.global().async(qos: .userInitiated) {
                guard snapshot.childrenCount == 0 else { return }
                var favorites: [Place]?
                
                for child in snapshot.children {
                    guard let data = child as? DataSnapshot else { continue }
                    guard let foundPlace = data.value as? JSON else { continue }
                    if let place = Place(with: foundPlace) {
                        favorites!.append(place)
                    }
                }
                
                DispatchQueue.main.async {
                    completionHandler(favorites)
                }
            }
        }
    }
    
    
    
    func saveNewPlace(with place: Place, completionHandler: @escaping () -> ()) {

        var placeName = "\(place.coordinates.latitude)"
        placeName = self.cutAllSymbols(in: placeName)
        let reference = self.ref.child(placeName)
        var tempPlace = place
        reference.setValue(tempPlace.convertToJSON())
    
    }
    
    
    
    private func cutAllSymbols(in string: String) -> String {
        let result = string.trimmingCharacters(in: ["+", "-"]).replacingOccurrences(of: ".", with: "")
        return result
    }
    
    
    
    func recreatePlaceDataReference(from databaseReference: DatabaseReference, and stringCoordinate: String) -> DatabaseReference {
        let cutCoordinate = self.cutAllSymbols(in: stringCoordinate)
        let recreatedReference = databaseReference.child(cutCoordinate)
        return recreatedReference
    }
    
    
}
