//
//  MainMapView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 07.06.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps

class MainMapView: UIView {
    private let viewController: MapViewController
    var mapView: GMSMapView?
    var searchTextField: UITextField?
    
    init(viewController: MapViewController) {
        self.viewController = viewController
        super.init(frame: CGRect.zero)
        viewController.view.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let map = GMSMapView(frame: CGRect.zero)
        self.addSubview(map)
        self.mapView = map
        
        map.translatesAutoresizingMaskIntoConstraints = false
        map.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.setMapCameraPosition(using: viewController.userCurrentLocation!, with: 15.0)
        map.delegate = viewController
        map.isMyLocationEnabled = true
        
        
        let textFieldFont = UIFont(name: "OpenSans", size: 15.0)
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        
        let atributedPlaceholder = NSMutableAttributedString(string: "find place")
        atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
        
        let searchTextField = UITextField()
        searchTextField.delegate = self.viewController
        searchTextField.borderStyle = .none
        searchTextField.backgroundColor = #colorLiteral(red: 0.8984448988, green: 0.8984448988, blue: 0.8984448988, alpha: 1)
        searchTextField.layer.cornerRadius = 13
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.borderColor = #colorLiteral(red: 0.7817531158, green: 0.7817531158, blue: 0.7817531158, alpha: 1)
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.autocorrectionType = .no
        searchTextField.autocapitalizationType = .words
        self.addSubview(searchTextField)
        self.bringSubview(toFront: searchTextField)
        self.searchTextField = searchTextField
        
        let searchIconView = UILabel()
        searchIconView.text = "🔍"
        searchIconView.sizeToFit()
        searchTextField.leftView = searchIconView
        searchTextField.leftViewMode = .always
        searchTextField.font = textFieldFont!
        searchTextField.attributedPlaceholder = atributedPlaceholder
        
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        searchTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        searchTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        let signoutBarButton = UIBarButtonItem(title: "Sign out", style: .plain, target: viewController, action: #selector(MapViewController.signoutMethod))
        viewController.navigationItem.leftBarButtonItem = signoutBarButton
        
        let addNewPlaceBarButton = UIBarButtonItem(title: "New spot", style: .plain, target: viewController, action: #selector(MapViewController.addNewPlace))
        viewController.navigationItem.rightBarButtonItem = addNewPlaceBarButton
        
        
        
    }
    
    
    func setMapCameraPosition(using coordinates: CLLocationCoordinate2D, with zoom: Float) {
        let camera = GMSCameraPosition.camera(withTarget: coordinates, zoom: zoom)
        self.mapView!.animate(to: camera)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}