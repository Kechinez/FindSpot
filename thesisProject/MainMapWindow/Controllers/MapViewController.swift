//
//  MapViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 20.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate, UITabBarControllerDelegate {

    private var locationManager: CLLocationManager?
    private var userCurrentLocation: CLLocationCoordinate2D?
    private var userCurrentCity: String?
    private var mainView: MainWindowView?
    private var allPlaces: [Place]? = []
    private let googleAPIManager = GoogleApiRequests()
    private let databaseManager = DataBaseManager()
    var favorites: [Place]?
    private var userDatabaseRef: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabBarController = self.tabBarController {
            tabBarController.delegate = self
        }
        guard let currentUser = Auth.auth().currentUser else { return }
        self.userDatabaseRef = Database.database().reference(withPath: "users").child(String(currentUser.uid))
        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        mainView = MainWindowView(viewController: self, frame: CGRect(x: 0, y: topBarHeight, width: self.view.bounds.width, height: self.view.bounds.height - topBarHeight))
        
        self.view.addSubview(mainView!)
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self

        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager!.requestWhenInUseAuthorization()
        }
        locationManager!.requestWhenInUseAuthorization()
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest//kCLLocationAccuracyNearestTenMeters
        self.userCurrentLocation = locationManager!.location!.coordinate
        
        self.googleAPIManager.coordinatesToAddressRequest(with: self.userCurrentLocation!) { (city) in
            guard let city = city else { return }
            self.userCurrentCity = city.cityName
            
            self.databaseManager.getPlacesWithin(city: self.userCurrentCity!) { (places) in
                if let places = places {
                    self.allPlaces = places
                    for place in self.allPlaces! {
                        self.showFoundPlace(with: place.coordinates, info: place.placeName)
                    }
                } else {
                    print("There is no available spots in this city!")
                }
            }
        }
  
    }
        

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let vc = viewController as? FavoritesViewController else { return }
        vc.favorites = self.favorites
        vc.userDatabaseRef = self.userDatabaseRef!
    }
    
    
    
    
    
    // MARK: - UITextField Delegate methods:
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //в этом методе вызывать запрос загрузки координат мест в введеном городе
        return true
    }
    
    
    
    

    // MARK: - Methods showing map's elements:
    
    func showFoundPlace(with coordinates: CLLocationCoordinate2D, info: String) {
        let marker = GMSMarker()
        marker.position = coordinates
        marker.title = info
        marker.map = self.mainView!.mapView
    }
    
    
    
    
    
    // MARK: - GMSMapView Delegate methods:
    
//    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
//        let placeVC = PlaceViewController()
//        placeVC.place = self.allPlaces![0]
//        self.present(placeVC, animated: true, completion: nil)
//    }
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        for (index, place) in self.allPlaces!.enumerated() {
            guard marker.position.latitude == place.coordinates.latitude,
                  marker.position.longitude == place.coordinates.longitude  else { continue }
            
            let placeVC = PlaceViewController()
            placeVC.place = self.allPlaces![index]
            placeVC.userLocation = self.userCurrentLocation!
            guard let navigationVC = self.tabBarController?.navigationController else { return true }
            navigationVC.pushViewController(placeVC, animated: true)
            //self.navigationController!.pushViewController(placeVC, animated: true)
        }
        return true
    }
    
    
    
    // MARK: - NavigationBar's buttons action methods:
    
     @objc func addNewPlace() {
        
    }
    
    
}
