//
//  DownloadURL.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 13.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation

class DownloadURL {
    var threadSafeURLs: [URL]? = []
    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)
    
    func append(downloadURL: URL?, with currentDispatchGroup: DispatchGroup) {
        queue.async(flags: .barrier) {
            
            if let tempURL = downloadURL {
                self.threadSafeURLs!.append(tempURL)
                currentDispatchGroup.leave()
            }
        }
    }
    
    
}
