//
//  PlaceViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 07.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps
class PlaceViewController: UIViewController, UINavigationControllerDelegate, GMSMapViewDelegate {
    private var images: [UIImage] = []
    private var placeView: PlaceView?
    var place: Place?
    private var imagesCollectionView: ImagesCollectionController?
    var userLocation: CLLocationCoordinate2D?
    private var distanceForInfoWin: String?
    private var timeForInfoWin: String?
    private var infoWindow: InfoWindowView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GoogleApiRequests.shared.getRouteRequest(with: self.userLocation!, and: self.place!.coordinates) { (route) in
            switch route {
            case  .Success(let route):
                self.distanceForInfoWin = route.distance
                self.timeForInfoWin = route.time
                self.showPath(polyline: route.polylinePath)
            case .Failure(let error):
                ErrorManager.shared.showErrorMessage(with: error, shownAt: self)
                return
            }
        }
        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let placeView = PlaceView(with: CGRect(x: 0, y: topBarHeight, width: self.view.frame.size.width, height: self.view.frame.size.height - topBarHeight) , place: self.place!, and: self)
        self.placeView = placeView
        
        PhotoManager.shared.getPhotoFromStorage(using: place!.photosDownloadURLs) { (images) in
            guard let tempImages = images.threadSafeImages else { return }
            self.images = tempImages
            self.setUpImages()
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = true
        }
    }
    
    
    
    
    
    // MARK: - Methods showing map's elements:
    
    
    func showPath(polyline: String) {
        let path = GMSPath(fromEncodedPath: polyline)
        DispatchQueue.main.async {
            let polylineDraw = GMSPolyline(path: path)
            polylineDraw.strokeWidth = 3.0
            polylineDraw.strokeColor = UIColor.red
            polylineDraw.map = self.placeView!.mapView!
        }
    }
    
    
    
    func setUpRouteDetails() {
        if self.distanceForInfoWin != nil && self.timeForInfoWin != nil {
            self.infoWindow!.distanceLable!.text = "route distance: \(self.distanceForInfoWin!)"
            self.infoWindow!.timeLable!.text = "route time: \(self.timeForInfoWin!)"
        }
    }
    
    
    
    
    
    
    // MARK: - GMSMapView Delegate methods:
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        if self.infoWindow == nil {
            let infoWindow = InfoWindowView(frame: CGRect(x: 0, y: 0, width: 200, height: 50), with: self)
            self.placeView!.addSubview(infoWindow)
            self.infoWindow = infoWindow
            self.setUpRouteDetails()
            return infoWindow
        } else {
            self.setUpRouteDetails()
            return self.infoWindow!
        }
    }
    
    
    
    
    
    
    
    // MARK: - Additional methods
    
    
    @objc func addToFavorites() {
        self.navigationItem.rightBarButtonItem!.isEnabled = false
        self.navigationItem.rightBarButtonItem!.tintColor = #colorLiteral(red: 0.8497060029, green: 0.8497060029, blue: 0.8497060029, alpha: 1)
        DataBaseManager.shared.addPlaceToFavorites(with: self.place!)
    }
    
    
    
    @objc func showSpotsImagesMethod() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let imagesCollection = ImagesCollectionController(collectionViewLayout: layout, expectedNumberOfItems: self.place!.photosDownloadURLs.count)
        self.imagesCollectionView = imagesCollection
        
        if self.images.count > 0 {
            imagesCollection.images = self.images
        }
        guard let navigationVC = self.navigationController else { return }
        navigationVC.pushViewController(imagesCollection, animated: true)
    }
    
    
    
    func setUpImages() {
        guard let imagesCollection = self.imagesCollectionView else { return }
        imagesCollection.images = self.images
    }
    
    
}
