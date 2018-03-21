//
//  MapView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 21.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps

class MapView: GMSMapView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let camera = GMSCameraPosition.camera(withLatitude: 61.690201, longitude: 27.272632, zoom: 14.0)
        self.camera = camera
        self.showUsersPositionWith(coordinates: camera.target)
        //self.showUsersPosition(with, coordinates: camera.target)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showUsersPositionWith(coordinates: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinates)
        marker.title = "Sokos paradise"
        marker.snippet = "Mikkeli"
        marker.map = self
    }
    
    
}
