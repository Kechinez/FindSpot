//
//  PlaceViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 07.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps
class PlaceViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UINavigationControllerDelegate, GMSMapViewDelegate {
    private var images: [UIImage] = []
    var placeView: PlaceView?
    var place: Place?
    var collectionView: UICollectionView?
    var userLocation: CLLocationCoordinate2D?
    let googleApiManager = GoogleApiRequests()
    var distanceForInfoWin: String?
    var timeForInfoWin: String?
    var infoWindow: InfoWindowView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.googleApiManager.getRouteRequest(with: self.userLocation!, and: self.place!.coordinates) { (route) in
            guard let routeInfo = route else { return }
            self.distanceForInfoWin = routeInfo.distance
            self.timeForInfoWin = routeInfo.time
            
            self.showPath(polyline: routeInfo.polylinePath)
        }

        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        let placeView = PlaceView(with: CGRect(x: 0, y: topBarHeight, width: self.view.frame.size.width, height: self.view.frame.size.height - topBarHeight), placeCoordinate: place!.coordinates, placeDescription: place!.placeDescription, corespondingVC: self)
        self.view.addSubview(placeView)
        self.placeView = placeView
        
        let photoManager = PhotoManager()
        photoManager.getPhotoFromStorage(using: place!.photosDownloadURLs) { (images) in
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
    
    
    
    
    // MARK: - CollectionView dataSource methods:
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoSlider = PhotoSliderViewController()
        photoSlider.currentIndex = indexPath.row
        photoSlider.images = self.images
        self.navigationController!.pushViewController(photoSlider, animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.place!.photosDownloadURLs.count // потом обратить на это внимание!!!!!! из
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ImagesCollectionCell
        if images.count > 0 {
            cell.imageView.image = images[indexPath.row]
        }
        return cell
    }
    
    
    func setUpImages() {
        self.collectionView!.reloadData()
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
        self.infoWindow!.distanceLable!.text = self.distanceForInfoWin!
        self.infoWindow!.timeLable!.text = self.timeForInfoWin!
    }

    
    
    
    
    
    // MARK: - GMSMapView Delegate methods:

    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        if self.infoWindow == nil {
            let infoWindow = InfoWindowView(frame: CGRect(x: 0, y: 0, width: 140, height: 50), with: self)
            self.placeView!.addSubview(infoWindow)
            self.infoWindow = infoWindow
            self.setUpRouteDetails()
            return infoWindow
        } else {
            self.setUpRouteDetails()
            return self.infoWindow!
        }
    }
    
    
    
}
