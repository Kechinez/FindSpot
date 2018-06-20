//
//  PlaceView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 07.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceView: UIScrollView {
    var mapView: GMSMapView?
    private let viewController: PlaceViewController
    private var addToFavoritesButton: UIButton?
    private var descriptionLabel: UILabel?
    private var backgroundView: UIImageView?
    private var nameLabel: UILabel?
    private var cityLabel: UILabel?
    private var blackBackgroundView: UIView?
    private var collectionView: UICollectionView?
    private var contentView: UIView?
    private var collectionViewHeight: CGFloat?
    private var showSpotsImagesButton: UIButton?
    
    
    init(with frame: CGRect, place: Place, and corespondingVC: PlaceViewController) {
        self.viewController = corespondingVC
        super.init(frame: frame)
        corespondingVC.view.addSubview(self)
        self.collectionViewHeight = frame.width
        
        let contentView = UIView(frame: CGRect.zero)
        self.contentView = contentView
        self.addSubview(contentView)
        
        let leavesImage = UIImage(named: "Leaves.png")
        let backgroundView = UIImageView()
        backgroundView.image = leavesImage
        backgroundView.alpha = 0.45
        contentView.addSubview(backgroundView)
        self.bringSubview(toFront: backgroundView)
        self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        self.backgroundView = backgroundView
        
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "OpenSans", size: 25)
        nameLabel.textColor = .white
        nameLabel.text = place.placeName
        contentView.addSubview(nameLabel)
        self.nameLabel = nameLabel
        
        
        let cityLabel = UILabel()
        cityLabel.font = UIFont(name: "OpenSans", size: 19)
        cityLabel.textColor = .white
        cityLabel.text = place.city
        contentView.addSubview(cityLabel)
        self.cityLabel = cityLabel
        
        let map = GMSMapView()
        map.layer.borderColor = #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1)
        map.layer.borderWidth = 1.0
        let placeMarker = GMSMarker(position: place.coordinates)
        placeMarker.map = map
        self.mapView = map
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinates.latitude, longitude: place.coordinates.longitude, zoom: 15.0)
        self.mapView!.camera = camera
        contentView.addSubview(self.mapView!)
        self.mapView!.delegate = corespondingVC
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = place.placeDescription
        descriptionLabel.font = UIFont(name: "OpenSans", size: 18)
        descriptionLabel.textColor = .white
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        self.descriptionLabel = descriptionLabel
        descriptionLabel.layer.cornerRadius = 7.0
        contentView.addSubview(descriptionLabel)
        
        let buttonFont = UIFont(name: "OpenSans", size: 19.0)
        let showImagesButton = UIButton()
        showImagesButton.setTitle("Show spot's images", for: .normal)
        showImagesButton.setTitleColor(UIColor.white, for: .normal)
        showImagesButton.titleLabel?.font = buttonFont
        showImagesButton.layer.cornerRadius = 8.0
        showImagesButton.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
        showImagesButton.addTarget(self.viewController, action: #selector(PlaceViewController.showSpotsImagesMethod), for: .touchUpInside)
        contentView.addSubview(showImagesButton)
        self.showSpotsImagesButton = showImagesButton
        
        let addToFavoritesButton = UIBarButtonItem(title: "Add spot", style: .plain, target: corespondingVC, action: #selector(PlaceViewController.addToFavorites))
        corespondingVC.navigationItem.rightBarButtonItem = addToFavoritesButton
    
        self.setUpConstraints()
    }
    
    
    
    private func setUpConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: self.viewController.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: self.viewController.view.widthAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.viewController.view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        self.contentView!.translatesAutoresizingMaskIntoConstraints = false
        self.contentView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.contentView!.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.backgroundView!.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView!.topAnchor.constraint(equalTo: self.contentView!.topAnchor).isActive = true
        self.backgroundView!.widthAnchor.constraint(equalTo: self.contentView!.widthAnchor).isActive = true
        self.backgroundView!.heightAnchor.constraint(equalTo: self.contentView!.heightAnchor, multiplier: 0.5).isActive = true
        
        self.nameLabel!.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel!.topAnchor.constraint(equalTo: self.contentView!.topAnchor, constant: 20).isActive = true
        self.nameLabel!.leadingAnchor.constraint(equalTo: self.contentView!.leadingAnchor, constant: 20).isActive = true
        self.nameLabel!.trailingAnchor.constraint(equalTo: self.contentView!.trailingAnchor).isActive = true
        self.nameLabel!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.cityLabel!.translatesAutoresizingMaskIntoConstraints = false
        self.cityLabel!.topAnchor.constraint(equalTo: self.nameLabel!.bottomAnchor).isActive = true
        self.cityLabel!.leadingAnchor.constraint(equalTo: self.contentView!.leadingAnchor, constant: 20).isActive = true
        self.cityLabel!.trailingAnchor.constraint(equalTo: self.contentView!.trailingAnchor).isActive = true
        self.cityLabel!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.mapView!.translatesAutoresizingMaskIntoConstraints = false
        self.mapView!.topAnchor.constraint(equalTo: self.cityLabel!.bottomAnchor, constant: 20).isActive = true
        self.mapView!.leadingAnchor.constraint(equalTo: self.contentView!.leadingAnchor, constant: 20).isActive = true
        self.mapView!.trailingAnchor.constraint(equalTo: self.contentView!.trailingAnchor, constant: -20).isActive = true
        self.mapView!.heightAnchor.constraint(equalTo: self.contentView!.widthAnchor).isActive = true
        
        self.descriptionLabel!.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel!.topAnchor.constraint(equalTo: self.mapView!.bottomAnchor, constant: 20).isActive = true
        self.descriptionLabel!.leadingAnchor.constraint(equalTo: self.contentView!.leadingAnchor, constant: 20).isActive = true
        self.descriptionLabel!.widthAnchor.constraint(equalToConstant: self.frame.width - 40).isActive = true
        
        self.showSpotsImagesButton!.translatesAutoresizingMaskIntoConstraints = false
        self.showSpotsImagesButton!.topAnchor.constraint(equalTo: self.descriptionLabel!.bottomAnchor, constant: 50).isActive = true
        self.showSpotsImagesButton!.centerXAnchor.constraint(equalTo: self.contentView!.centerXAnchor).isActive = true
        self.showSpotsImagesButton!.widthAnchor.constraint(equalTo: self.contentView!.widthAnchor, multiplier: 0.6).isActive = true
        self.showSpotsImagesButton!.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.showSpotsImagesButton!.bottomAnchor.constraint(equalTo: self.contentView!.bottomAnchor, constant: -20).isActive = true
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
