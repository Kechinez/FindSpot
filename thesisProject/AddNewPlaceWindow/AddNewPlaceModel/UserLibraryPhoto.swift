//
//  UserLibraryPhoto.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 12.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
struct UserLibraryPhoto {
    let image: UIImage
    let location: CLLocationCoordinate2D
    
    //lazy var 
    lazy var stringLocation: String = {
        return "\(location.latitude)"
    }()
    
    init(image: UIImage, photoLocation: CLLocationCoordinate2D) {
        self.image = image
        self.location = photoLocation
    }
}
