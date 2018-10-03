//
//  DataBaseManager.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 05.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import Firebase

final class DataBaseManager {
    static let shared = DataBaseManager()
    var userRef: DatabaseReference?
    private let ref: DatabaseReference = Database.database().reference(withPath: "places")
    
    private init() {}
    
    //MARK: getting list of places methods
    func getPlacesWithin(city: String, completionHandler: @escaping (APIResult<[Place]>) -> ()) {
        let modifiedCityString = removingSpaces(in: city)
        let placesQuery = self.ref.queryOrdered(byChild: "city").queryEqual(toValue: modifiedCityString)
        
        placesQuery.observeSingleEvent(of: .value, with: { (data) in
            var placesArray: [Place] = []
            let parsingDataQueue = DispatchQueue.global(qos: .userInitiated)
            
            parsingDataQueue.async {
                guard data.childrenCount != 0 else  {
                    let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Couldn't download spots in \(city)", comment: "")]
                    let error = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                    DispatchQueue.main.async {
                        completionHandler(.Failure(error))
                    }
                    return
                }
                for child in data.children {
                    guard let data = child as? DataSnapshot else { continue }
                    guard let foundPlace = data.value as? JSON else { continue }
                    if let tempPlace = Place(with: foundPlace) {
                        placesArray.append(tempPlace)
                    }
                }
                DispatchQueue.main.async {
                    completionHandler(.Success(placesArray))
                }
            }
        })
    }
    
    func getUserFavorites(completionHandler: @escaping (APIResult<[Place]>) -> ()) {
        guard let ref = userRef else { return }
        ref.observe(.value) { (snapshot) in
            DispatchQueue.global().async(qos: .userInitiated) {
                guard snapshot.childrenCount != 0 else {
                    let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Couldn't download user's Favorites", comment: "")]
                    let error = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                    DispatchQueue.main.async {
                        completionHandler(.Failure(error))
                    }
                    return
                }
                var favorites: [Place] = []
                for child in snapshot.children {
                    guard let data = child as? DataSnapshot else { continue }
                    guard let foundPlace = data.value as? JSON else { continue }
                    if let place = Place(with: foundPlace) {
                        favorites.append(place)
                    }
                }
                DispatchQueue.main.async {
                    completionHandler(.Success(favorites))
                }
            }
        }
    }
    
    //MARK: database interaction methods
    func saveNewPlace(with place: Place, completionHandler: @escaping () -> ()) {
        var tempPlace = place
        var placeName = tempPlace.stringLatitude
        placeName = cuttingAllSymbols(in: placeName)
        let reference = self.ref.child(placeName)
        reference.setValue(tempPlace.convertingToJSON())
        completionHandler()
    }
    
    func deleteDatabaseValue(with stringCoordinate: String) {
        let deleteRef = recreatingPlaceDataReference(from: stringCoordinate)
        deleteRef.removeValue()
    }
    
    func addPlaceToFavorites(with place: Place) {
        var placeName = "\(place.coordinates.latitude)"
        placeName = cuttingAllSymbols(in: placeName)
        guard let ref = userRef?.child(placeName) else { return }
        var tempPlace = place
        ref.setValue(tempPlace.convertingToJSON())
    }
    
    // MARK: - helping methods
    private func cuttingAllSymbols(in string: String) -> String {
        let result = string.trimmingCharacters(in: ["+", "-"]).replacingOccurrences(of: ".", with: "")
        return result
    }
    
    private func removingSpaces(in string: String) -> String {
        let result = string.trimmingCharacters(in: [" "]).replacingOccurrences(of: "-", with: " ").capitalized(with: nil)
        return result
    }
    
    private func recreatingPlaceDataReference(from stringCoordinate: String) -> DatabaseReference {
        let cutCoordinate = cuttingAllSymbols(in: stringCoordinate)
        let recreatedReference = self.userRef!.child(cutCoordinate)
        return recreatedReference
    }
    
}
