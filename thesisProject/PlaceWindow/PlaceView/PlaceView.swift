//
//  PlaceView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 07.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceView: UIView {
    var mapView: GMSMapView?
    
    init(with frame: CGRect, placeCoordinate: CLLocationCoordinate2D, placeDescription: String, corespondingVC: PlaceViewController) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        
        //let map = GMSMapView(frame: CGRect(x: frame.size.width / 7, y: 20, width: frame.size.width * 5/7, height: frame.size.height / 2 - 20))
        let map = GMSMapView(frame: CGRect(x: self.bounds.size.width / 7, y: 20, width: self.bounds.size.width * 5/7, height: self.bounds.size.height / 2 - 20))
        map.layer.cornerRadius = 7.0
        let placeMarker = GMSMarker(position: placeCoordinate)
        placeMarker.map = map
        self.mapView = map
        let camera = GMSCameraPosition.camera(withLatitude: placeCoordinate.latitude, longitude: placeCoordinate.longitude, zoom: 15.0)
        self.mapView!.camera = camera
        self.addSubview(self.mapView!)
        self.mapView!.delegate = corespondingVC
        
        //let desciptionLabel = UILabel(frame: CGRect(x: frame.size.width / 7, y: frame.size.height / 2 + 20, width: frame.size.width * 5/7, height: frame.size.height / 4 - 20))
        let desciptionLabel = UILabel(frame: CGRect(x: self.bounds.size.width / 7, y: self.bounds.size.height / 2 + 20, width: self.bounds.size.width * 5/7, height: self.bounds.size.height / 4 - 20))
        desciptionLabel.layer.cornerRadius = 7.0
        desciptionLabel.text = placeDescription
        self.addSubview(desciptionLabel)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.minimumInteritemSpacing = 20
        //layout.itemSize = CGSize(width: frame.size.height / 5 - 10, height: frame.size.height / 5 - 10)
        layout.itemSize = CGSize(width: self.bounds.size.height / 5 - 10, height: self.bounds.size.height / 5 - 10)
        layout.scrollDirection = .horizontal
        
        //let imagesCollection = UICollectionView(frame: CGRect(x: frame.size.width / 7, y: frame.size.height / 3 * 4 + 20, width: frame.size.width * 5/7, height: frame.size.height / 5), collectionViewLayout: layout)
        let imagesCollection = UICollectionView(frame: CGRect(x: self.bounds.size.width / 7, y: self.bounds.size.height / 4 * 3 + 20, width: self.bounds.size.width * 5/7, height: self.bounds.size.height / 5), collectionViewLayout: layout)
        imagesCollection.register(ImagesCollectionCell.self, forCellWithReuseIdentifier: "MyCell")
        imagesCollection.dataSource = corespondingVC
        imagesCollection.delegate = corespondingVC

        imagesCollection.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        imagesCollection.layer.cornerRadius = 7
        self.addSubview(imagesCollection)
        corespondingVC.collectionView = imagesCollection
        
    
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
