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
    private var descriptionLabel: UILabel?
    
    init(with frame: CGRect, place: Place, and corespondingVC: PlaceViewController) {
        super.init(frame: frame)
        
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
        nameLabel.text = place.placeName
        self.addSubview(nameLabel)
        
        let cityLabel = UILabel(frame: CGRect(x: 20, y: 50, width: self.bounds.width - 40, height: 30))
        cityLabel.font = UIFont(name: "OpenSans", size: 19)
        cityLabel.textColor = .white
        cityLabel.text = place.city
        self.addSubview(cityLabel)
        
        let map = GMSMapView(frame: CGRect(x: 20, y: 100, width: self.bounds.size.width - 40, height: self.bounds.size.width - 40))
        map.layer.borderColor = #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1)
        map.layer.borderWidth = 1.0
        let placeMarker = GMSMarker(position: place.coordinates)
        placeMarker.map = map
        self.mapView = map
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinates.latitude, longitude: place.coordinates.longitude, zoom: 15.0)
        self.mapView!.camera = camera
        self.addSubview(self.mapView!)
        self.mapView!.delegate = corespondingVC
        
        let blackBackgroundView = UIView(frame: CGRect(x: 0, y: self.bounds.size.width + 80, width: self.bounds.size.width, height: self.bounds.height - self.bounds.size.width + 80))
        blackBackgroundView.backgroundColor = .black
        blackBackgroundView.alpha = 0.2
        self.addSubview(blackBackgroundView)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = place.placeDescription
        descriptionLabel.font = UIFont(name: "OpenSans", size: 18)
        descriptionLabel.textColor = .white
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        self.descriptionLabel = descriptionLabel
        self.setNeedsLayout()
        descriptionLabel.layer.cornerRadius = 7.0
        self.addSubview(descriptionLabel)
        
        let labelHeight = descriptionLabel.frame.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 30
        let itemSide = self.bounds.size.width - 70
        
        layout.itemSize = CGSize(width: itemSide, height: itemSide)
        layout.scrollDirection = .horizontal
        
        let imagesCollectionHeight = itemSide + 10
        
        let imagesCollection = UICollectionView(frame: CGRect(x: 20, y: self.frame.width + 100 + labelHeight, width: self.bounds.size.width - 40, height: imagesCollectionHeight + 20), collectionViewLayout: layout)
        
        imagesCollection.register(ImagesCollectionCell.self, forCellWithReuseIdentifier: "PlaceViewCell")
        imagesCollection.dataSource = corespondingVC
        imagesCollection.delegate = corespondingVC

        imagesCollection.backgroundColor = UIColor.clear
        self.addSubview(imagesCollection)
        corespondingVC.collectionView = imagesCollection
        
        let totalHeight = (self.frame.width + 120 + labelHeight + imagesCollection.frame.size.height) - self.bounds.height
        self.contentSize = CGSize(width: self.bounds.width, height: self.bounds.height + totalHeight)
        self.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: self.bounds.height, right: 0)
        blackBackgroundView.frame.size = self.contentSize
    
        
        let addToFavoritesButton = UIBarButtonItem(title: "Add spot", style: .plain, target: corespondingVC, action: #selector(PlaceViewController.addToFavorites))
        corespondingVC.navigationItem.rightBarButtonItem = addToFavoritesButton
    
    }
    
    
    
    override func setNeedsLayout() {
        self.descriptionLabel!.frame = CGRect(x: 0, y: 0, width: bounds.width - 40, height: 0)
        self.descriptionLabel!.sizeToFit()
        self.descriptionLabel!.frame.size = self.descriptionLabel!.bounds.size
        self.descriptionLabel!.frame.origin = CGPoint(x: 20, y: self.frame.width + 80)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
