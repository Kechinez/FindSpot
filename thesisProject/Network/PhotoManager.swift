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

final class PhotoManager {
    private let ref = StorageReference()
    private var images = Photo()
    private let storage = Storage.storage()
    private let dispatchGroup = DispatchGroup()
    private var downloadURLs = DownloadURL()
    private var fileFolderName: String?
    static let shared = PhotoManager()
    
    private init() {}
    
    //MARK: - upload/download image
    func getPhotoFromStorage(using URLs: [URL], with completionHandler: @escaping (Photo) -> ()) {
        self.images.threadSafeImages = []
        
        DispatchQueue.global(qos: .utility).async(group: dispatchGroup) {
            for url in URLs {
                self.dispatchGroup.enter()
                let gsReference = self.storage.reference(forURL: url.absoluteString)
                gsReference.getData(maxSize: 6 * 1024 * 1024) { [unowned self] (data, error) in
                    guard error == nil && data != nil else {
                        print(error!.localizedDescription)
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
    
    func uploadPhotos(with photos: [UIImage], and location: CLLocationCoordinate2D, comletionHandler: @escaping ([URL]?) -> ()) {
        
        DispatchQueue.global(qos: .utility).async(group: dispatchGroup) {
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            for (index, photo) in photos.enumerated() {
                self.dispatchGroup.enter()
                guard let data = UIImagePNGRepresentation(photo) else { break }
                let storageRef = self.createStorageReferenceFromCoordinate("\(location.latitude)", with: index)
                
                storageRef.putData(data, metadata: metaData) { [unowned self] (metaData, error) in
                    guard let metaData = metaData else { return }
                    if let downloadURL = metaData.downloadURL() {
                        self.downloadURLs.append(downloadURL: downloadURL, with: self.dispatchGroup)
                    }
                }
            }
            self.dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                comletionHandler(self.downloadURLs.threadSafeURLs)
            })
        }
    }
    
    //MARK: - supporting method
    private func createStorageReferenceFromCoordinate(_ coordinate: String, with photoIndex: Int) -> StorageReference {
        if self.fileFolderName == nil {
            self.fileFolderName = coordinate.trimmingCharacters(in: ["+", "-", ",", "/"]).replacingOccurrences(of: ".", with: "")
        }
        let fileName = "\(self.fileFolderName!)\(photoIndex)"
        return StorageReference().child("placesImages").child("\(self.fileFolderName!)/\(fileName)")
    }
}

