//
//  MapView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 21.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps

class MainWindowView: UIView {
    var mapView: GMSMapView?
    
    
    init(viewController: MapViewController, frame: CGRect) {
        super.init(frame: frame)
        
        mapView = GMSMapView(frame: CGRect(x: 0, y: 60, width: frame.size.width, height: frame.size.height - 80))
        let camera = GMSCameraPosition.camera(withLatitude: 61.690201, longitude: 27.272632, zoom: 14.0)
        mapView!.camera = camera
        mapView!.delegate = viewController
        self.addSubview(mapView!)
        mapView!.isMyLocationEnabled = true
        //self.showUsersPositionWith(coordinates: camera.target)
        //self.showUsersPosition(with, coordinates: camera.target)
        
        let searchTextField = UITextField(frame: CGRect(x: 10, y: 10, width: frame.size.width - 20, height: 40))
        searchTextField.borderStyle = .roundedRect
        searchTextField.placeholder = "find place"
        searchTextField.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(searchTextField)
        searchTextField.delegate = viewController
        
        self.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showUsersPositionWith(coordinates: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinates)
        marker.title = "Sokos paradise"
        marker.snippet = "Mikkeli"
        marker.map = mapView
    }
    
    
}
