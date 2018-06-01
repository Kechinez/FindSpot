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
    var userCurrentLocation: CLLocationCoordinate2D?
    private var userCurrentCity: String?
    private var mainView: MainWindowView?
    private var allPlaces: [Place]? = []
    private let googleAPIManager = GoogleApiRequests()
    //private let databaseManager = DataBaseManager()
    var favorites: [Place]?
    private var userDatabaseRef: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "FindSpot"
        guard let currentUser = Auth.auth().currentUser else { return }
        self.userDatabaseRef = Database.database().reference(withPath: "users").child(String(currentUser.uid)).child("favorites")
        DataBaseManager.shared.userRef = self.userDatabaseRef
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager!.requestWhenInUseAuthorization()
        }
        locationManager!.requestWhenInUseAuthorization()
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        self.userCurrentLocation = locationManager!.location!.coordinate
        
        if let tabBarController = self.tabBarController {
            tabBarController.delegate = self
        }
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0.0
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        mainView = MainWindowView(viewController: self, frame: CGRect(x: 0, y: topBarHeight, width: self.view.bounds.width, height: self.view.bounds.height - topBarHeight - tabBarHeight))
        
        self.view.addSubview(mainView!)
        
        let tempCoordinate = CLLocationCoordinate2D(latitude: 59.882023, longitude: 30.339113) //  temp coordinates should be used to emulate Saint-P current location
        
        self.googleAPIManager.coordinatesToAddressRequest(with: tempCoordinate) { (city) in
            
            switch city {
            case  .Success(let foundCity):
                self.userCurrentCity = foundCity.cityName
            case .Failure(let error):
                self.showGoogleMapError(with: error.localizedDescription)
                return
            }
            DataBaseManager.shared.getPlacesWithin(city: self.userCurrentCity!) { (places) in
                
                switch places {
                case  .Success(let places):
                    self.allPlaces = places
                    for place in self.allPlaces! {
                        self.showFoundPlace(with: place.coordinates, info: place.placeName)
                    }
                case .Failure(let error):
                    self.showGoogleMapError(with: error.localizedDescription)
                }
            
            }
        
        }
  
    }
        

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let favoritesVC = viewController as? UINavigationController else { return }
        guard let vc = favoritesVC.childViewControllers.first as? FavoritesViewController else { return }
        vc.userCurrentLocation = self.userCurrentLocation!
        
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
            guard let navigationVC = self.navigationController else { return true }
            navigationVC.pushViewController(placeVC, animated: true)
        }
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = false
        }

    }
    
    
    

    func showGoogleMapError(with error: String) {
        let alertViewController = UIAlertController(title: "Problem occured!", message: "\(error)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
        }
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    // MARK: - NavigationBar's buttons action methods:
    
     @objc func addNewPlace() {
        if let navigationController = self.navigationController {
            let newPlaceVC = AddNewPlaceViewController()
            navigationController.pushViewController(newPlaceVC, animated: true)
        }
    }
    
    
    
    @objc func signoutMethod() {
        do {
            try Auth.auth().signOut()
        } catch {
            ErrorManager.shared.showErrorMessage(with: error, shownAt: self)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}
