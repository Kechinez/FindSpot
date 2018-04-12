//
//  PhotoManager.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 07.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import FirebaseStorage
import CoreLocation
import UIKit

struct PhotoManager {
    
    private let ref = StorageReference()
    private var images = Photo()
    private let storage = Storage.storage()
    private let dispatchGroup = DispatchGroup()
    
    func getPhotoFromStorage(using URLs: [String], with completionHandler: @escaping (Photo) -> ()) {
        
        DispatchQueue.global(qos: .utility).async(group: dispatchGroup) {
            
            for url in URLs {
                self.dispatchGroup.enter()
                let gsReference = self.storage.reference(forURL: url)
                gsReference.getData(maxSize: 6 * 1024 * 1024) { (data, error) in
                    
                    if let problem = error {
                        print(problem.localizedDescription)
                        return
                    }
                    
                    self.images.append(data: data!, with: self.dispatchGroup)
                    
                }
                
            }
            
            self.dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                completionHandler(self.images)
            })
        }
    }

    
    func uploadPhotos(with photos: [UserLibraryPhoto], comletionHandler: @escaping ([String]) -> ()) {
        
        DispatchQueue.global(qos: .utility).async(group: dispatchGroup) {
            
            func createStorageReferenceFromCoordinate(coordinate: String, with photoIndex: Int) -> StorageReference {
                let fileFolderName = coordinate.trimmingCharacters(in: ["+", "-", ",", "."])
                let fileName = "\(fileFolderName)\(photoIndex)"
                return StorageReference().child("placesImages").child("\(fileFolderName)/\(fileName)")
            }
            
            
            for (index, var photo) in photos.enumerated() {
               
                self.dispatchGroup.enter()
                guard let data = UIImagePNGRepresentation(photo.image) else { break }
                let storageRef = createStorageReferenceFromCoordinate(coordinate: photo.stringLocation, with: index)
                
                storageRef.putData(data, metadata: nil) { (metaData, error) in
                    guard let metaData = metaData else { return }
                    metaData.downloadURLs
                }
            }
        
        
        }
        
        
    }
    
    

}




