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
    private let leavesImage: UIImageView = {
        let leavesImage = UIImageView(image: UIImage(named: "Leaves.png"))
        leavesImage.alpha = 0.45
        return leavesImage
    }()
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "OpenSans", size: 25)
        nameLabel.textColor = .white
        return nameLabel
    }()
    private let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = UIFont(name: "OpenSans", size: 19)
        cityLabel.textColor = .white
        return cityLabel
    }()
    public let map: GMSMapView = {
        let map = GMSMapView()
        map.layer.borderColor = #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1)
        map.layer.borderWidth = 1.0
        return map
    }()
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont(name: "OpenSans", size: 18)
        descriptionLabel.textColor = .white
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.layer.cornerRadius = 7.0
        return descriptionLabel
    }()
    private let showImagesButton: UIButton = {
        let showImagesButton = UIButton()
        showImagesButton.setButtonAppearance(.ShowSpotImagesButton)
        return showImagesButton
    }()
    private let contentView: UIView = {
        return UIView(frame: CGRect.zero)
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.contentView)
        self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        self.contentView.addSubview(self.leavesImage)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.cityLabel)
        self.contentView.addSubview(self.map)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.showImagesButton)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        for subview in self.contentView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        self.setUpConstraints()
    }
    
    //MARK: - updating UI
    func setUpLabelsText(accordingToThe place: Place) {
        self.nameLabel.text = place.placeName
        self.cityLabel.text = place.city
        self.descriptionLabel.text = place.placeDescription
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup button targets
    func setUpBarButtonItems(linkedWith viewController: PlaceViewController) {
        let addToFavoritesButton = UIBarButtonItem(title: "Add spot", style: .plain, target: viewController, action: #selector(PlaceViewController.addToFavorites))
            viewController.navigationItem.rightBarButtonItem = addToFavoritesButton
    }
    
    func setActionMethodForButtons(using viewController: PlaceViewController) {
        self.showImagesButton.addTarget(viewController, action: #selector(PlaceViewController.showSpotsImagesMethod), for: .touchUpInside)
    }
    
    //MARK: - Updating Map
    func setCameraAndMarkerOnTheMap(using coordinates: CLLocationCoordinate2D) {
        let placeMarker = GMSMarker(position: coordinates)
        placeMarker.map = self.map
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 15.0)
        self.map.camera = camera
    }
    
    //MARK: - Updating constraints
    private func setUpConstraints() {
        
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.leavesImage.translatesAutoresizingMaskIntoConstraints = false
        self.leavesImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.leavesImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        self.leavesImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5).isActive = true

        self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.cityLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
        self.cityLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.cityLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.cityLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
        self.map.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 20).isActive = true
        self.map.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.map.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.map.heightAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        
        self.descriptionLabel.topAnchor.constraint(equalTo: self.map.bottomAnchor, constant: 20).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        
        self.showImagesButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 50).isActive = true
        self.showImagesButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.showImagesButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.6).isActive = true
        self.showImagesButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.showImagesButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20).isActive = true
    }
    
}
