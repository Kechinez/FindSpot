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
    private var addToFavoritesButton: UIButton?
    
    init(with frame: CGRect, placeCoordinate: CLLocationCoordinate2D, corespondingVC: PlaceViewController, with placeName: String, and placeCity: String, and description: String) {
        super.init(frame: frame)
        
        self.contentSize = CGSize(width: self.bounds.width, height: self.bounds.height + 200)
        self.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: self.bounds.height, right: 0)
        
        let leavesImage = UIImage(named: "Leaves.png")
        let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height * 0.6))
        backgroundView.image = leavesImage
        backgroundView.alpha = 0.45
        self.addSubview(backgroundView)
        self.bringSubview(toFront: backgroundView)
        
        self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        
        
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 20, width: self.bounds.width - 40, height: 30))
        nameLabel.font = UIFont(name: "OpenSans", size: 25)
        nameLabel.textColor = .white
        nameLabel.text = placeName
        self.addSubview(nameLabel)
        
        let cityLabel = UILabel(frame: CGRect(x: 20, y: 50, width: self.bounds.width - 40, height: 30))
        cityLabel.font = UIFont(name: "OpenSans", size: 22)
        cityLabel.textColor = .white
        cityLabel.text = placeCity
        self.addSubview(cityLabel)
        
        let map = GMSMapView(frame: CGRect(x: 20, y: 100, width: self.bounds.size.width - 40, height: self.bounds.size.width - 40))
        map.layer.cornerRadius = 7.0
        let placeMarker = GMSMarker(position: placeCoordinate)
        placeMarker.map = map
        self.mapView = map
        let camera = GMSCameraPosition.camera(withLatitude: placeCoordinate.latitude, longitude: placeCoordinate.longitude, zoom: 15.0)
        self.mapView!.camera = camera
        self.addSubview(self.mapView!)
        self.mapView!.delegate = corespondingVC
        
        
        let addToFavoritesButton = UIButton(frame: CGRect(x: 20 + map.bounds.width * 0.2, y: self.bounds.size.width + 80, width: map.bounds.width * 0.6, height: 40))
        addToFavoritesButton.layer.cornerRadius = 8.0
        addToFavoritesButton.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
        addToFavoritesButton.setTitle("Add to favorites", for: .normal)
        addToFavoritesButton.titleLabel?.font = UIFont(name: "OpenSans", size: 16)
        addToFavoritesButton.setTitleColor(UIColor.white, for: .normal)
        addToFavoritesButton.addTarget(corespondingVC, action: #selector(PlaceViewController.addToFavorites), for: .touchUpInside)
        self.addSubview(addToFavoritesButton)
        self.addToFavoritesButton = addToFavoritesButton
        
        
        let descriptionLabel = UILabel(frame: CGRect(x: 20, y: self.bounds.size.width + 140, width: self.bounds.size.width - 40, height: self.bounds.size.height / 4 - 20))
        //descriptionLabel.layer.cornerRadius = 7.0
        //descriptionLabel.text = placeDescription
        descriptionLabel.numberOfLines = 6
        descriptionLabel.font = UIFont(name: "OpenSans", size: 18)
        descriptionLabel.textColor = .white
        descriptionLabel.text = description
        self.addSubview(descriptionLabel)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: self.bounds.size.height / 5 - 10, height: self.bounds.size.height / 5 - 10)
        layout.scrollDirection = .horizontal
        
        let imagesCollection = UICollectionView(frame: CGRect(x: self.bounds.size.width / 7, y: self.bounds.size.width + 155 + self.bounds.size.height / 4, width: self.bounds.size.width * 5/7, height: self.bounds.size.height / 5), collectionViewLayout: layout)
        imagesCollection.register(ImagesCollectionCell.self, forCellWithReuseIdentifier: "MyCell")
        imagesCollection.dataSource = corespondingVC
        imagesCollection.delegate = corespondingVC

        imagesCollection.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        imagesCollection.layer.cornerRadius = 7
        self.addSubview(imagesCollection)
        corespondingVC.collectionView = imagesCollection
        
    
        
    }
    
    func changeButtonColorToDark(bool: Bool) {
        if bool == true {
            self.addToFavoritesButton!.backgroundColor = #colorLiteral(red: 0.09287396601, green: 0.400906033, blue: 0.5654022416, alpha: 1)
            self.addToFavoritesButton!.setTitle("Remove from favorites", for: .normal)
        } else {
            self.addToFavoritesButton!.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
            self.addToFavoritesButton!.setTitle("Add to favorites", for: .normal)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
