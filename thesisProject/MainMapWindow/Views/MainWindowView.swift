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
        
        mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        let camera = GMSCameraPosition.camera(withTarget: viewController.userCurrentLocation!, zoom: 16.0)
        mapView!.camera = camera
        mapView!.delegate = viewController
        self.addSubview(mapView!)
        mapView!.isMyLocationEnabled = true
       
        let textFieldFont = UIFont(name: "OpenSans", size: 15.0)
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        
        let atributedPlaceholder = NSMutableAttributedString(string: "find place")
        atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
        
        let searchTextField = UITextField(frame: CGRect(x: frame.size.width / 6, y: 10, width: frame.size.width * 2/3, height: 40))
        searchTextField.borderStyle = .none
        searchTextField.backgroundColor = #colorLiteral(red: 0.8984448988, green: 0.8984448988, blue: 0.8984448988, alpha: 1)
        searchTextField.layer.cornerRadius = 13
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.borderColor = #colorLiteral(red: 0.7817531158, green: 0.7817531158, blue: 0.7817531158, alpha: 1)
        searchTextField.clearButtonMode = .whileEditing
        let searchIconView = UILabel()
        searchIconView.text = "🔍"
        searchIconView.sizeToFit()
        searchTextField.leftView = searchIconView
        searchTextField.leftViewMode = .always
        searchTextField.font = textFieldFont!
        searchTextField.attributedPlaceholder = atributedPlaceholder
        self.addSubview(searchTextField)
        self.bringSubview(toFront: searchTextField)
        searchTextField.delegate = viewController
        
        let signoutBarButton = UIBarButtonItem(title: "Sign out", style: .plain, target: viewController, action: #selector(MapViewController.signoutMethod))
        viewController.navigationItem.leftBarButtonItem = signoutBarButton
        
        let addNewPlaceBarButton = UIBarButtonItem(title: "New spot", style: .plain, target: viewController, action: #selector(MapViewController.addNewPlace))
        viewController.navigationItem.rightBarButtonItem = addNewPlaceBarButton
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
