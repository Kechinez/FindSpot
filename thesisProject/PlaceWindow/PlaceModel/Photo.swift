//
//  Photo.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 07.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    var threadSafeImages: [UIImage]? = []
    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)//DispatchQueue.global(qos: .userInitiated)//
    
    func append(data: Data?, with currentDispatchGroup: DispatchGroup) {
        queue.async(flags: .barrier) {
            
            if let tempData = data {
                self.threadSafeImages!.append(UIImage(data: tempData)!)
                currentDispatchGroup.leave()
            }
        }
    }
    
    

}
