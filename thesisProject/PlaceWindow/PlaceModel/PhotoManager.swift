//
//  PhotoManager.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 07.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import FirebaseStorage

struct PhotoManager {
    
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


}





