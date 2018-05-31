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
        
//        if let navigationVC = viewController.navigationController {
//            let addPlaceButton = UIBarButtonItem(title: "New spot", style: .plain, target: viewController, action: #selector(MapViewController.addNewPlace))
//            navigationVC.navigationItem.rightBarButtonItem = addPlaceButton
//        }
        
        mapView = GMSMapView(frame: CGRect(x: 0, y: 60, width: frame.size.width, height: frame.size.height - 80))
        let camera = GMSCameraPosition.camera(withTarget: viewController.userCurrentLocation!, zoom: 16.0)//(withLatitude: 61.690201, longitude: 27.272632, zoom: 14.0)
        mapView!.camera = camera
        mapView!.delegate = viewController
        self.addSubview(mapView!)
        mapView!.isMyLocationEnabled = true
        
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        
        let atributedPlaceholder = NSMutableAttributedString(string: "find place")
        atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
        
        let searchTextField = UITextField(frame: CGRect(x: 10, y: 10, width: frame.size.width - 20, height: 40))
        searchTextField.borderStyle = .roundedRect
        searchTextField.attributedPlaceholder = atributedPlaceholder
        self.addSubview(searchTextField)
        searchTextField.delegate = viewController
        
        self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
    
        let signoutBarButton = UIBarButtonItem(title: "Sign out", style: .plain, target: viewController, action: #selector(MapViewController.signoutMethod))
        viewController.navigationItem.leftBarButtonItem = signoutBarButton
        
        let addNewPlaceBarButton = UIBarButtonItem(title: "New spot", style: .plain, target: viewController, action: #selector(MapViewController.addNewPlace))
        viewController.navigationItem.rightBarButtonItem = addNewPlaceBarButton
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
