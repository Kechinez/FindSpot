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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.mapView)
        self.addSubview(searchTextField)
        
        for subview in self.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        self.setUpConstraints()
    }
    
    
    
    private func setUpConstraints() {
 
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        self.searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        self.searchTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.searchTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        self.searchTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    
    
    func setMapCameraPosition(using coordinates: CLLocationCoordinate2D, with zoom: Float) {
        let camera = GMSCameraPosition.camera(withTarget: coordinates, zoom: zoom)
        self.mapView.animate(to: camera)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
