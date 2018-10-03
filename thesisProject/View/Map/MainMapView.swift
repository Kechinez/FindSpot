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
    
    public let mapView: GMSMapView = {
        let map = GMSMapView(frame: CGRect.zero)
        return map
    }()
    public let searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.borderStyle = .none
        searchTextField.backgroundColor = #colorLiteral(red: 0.8984448988, green: 0.8984448988, blue: 0.8984448988, alpha: 1)
        searchTextField.layer.cornerRadius = 13
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.borderColor = #colorLiteral(red: 0.7817531158, green: 0.7817531158, blue: 0.7817531158, alpha: 1)
        searchTextField.setTextAndFont(.FindPlaceTextFeild)
        searchTextField.setKeyboardSettings(.FindPlaceTextFeild)
        let searchIconView = UILabel()
        searchIconView.text = "🔍"
        searchIconView.sizeToFit()
        searchTextField.leftView = searchIconView
        searchTextField.leftViewMode = .always
        return searchTextField
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.mapView)
        self.addSubview(self.searchTextField)
        for subview in self.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        self.setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup button targets
    func setBarButtonItems(linkedWith viewController: MapViewController) {
        let signoutBarButton = UIBarButtonItem(title: "Sign out", style: .plain, target: viewController, action: #selector(MapViewController.signoutMethod))
        viewController.navigationItem.leftBarButtonItem = signoutBarButton
        
        let addNewPlaceBarButton = UIBarButtonItem(title: "New spot", style: .plain, target: viewController, action: #selector(MapViewController.addNewPlace))
        viewController.navigationItem.rightBarButtonItem = addNewPlaceBarButton
    }
    
    //MARK: = updating constraints
    private func setUpConstraints() {
        self.mapView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 70).isActive = true
        self.searchTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.searchTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        self.searchTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    //MARK: - Updating map
    func setMapCameraPosition(using coordinates: CLLocationCoordinate2D, with zoom: Float) {
        let camera = GMSCameraPosition.camera(withTarget: coordinates, zoom: zoom)
        self.mapView.animate(to: camera)
    }
}
