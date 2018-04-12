//
//  MapViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 20.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps
class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {

    private var locationManager: CLLocationManager?
    private var userCurrentLocation: CLLocationCoordinate2D?
    private var userCurrentCity: String?
    private var mainView: MainWindowView?
    private var allPlaces: [Place]? = []
    private let googleAPIManager = GoogleApiRequests()
    private let databaseManager = DataBaseManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        

    
    
    
    
    // MARK: - UITextField Delegate methods:
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //в этом методе вызывать запрос загрузки координат мест в введеном городе
        return true
    }
    
    
    
    

    // MARK: - Methods showing map's elements:
    
    func showFoundPlace(with coordinates: CLLocationCoordinate2D, info: String) {
        let placePin = GMSMarker()
        placePin.position = coordinates
        placePin.title = info
        placePin.map = self.mainView!.mapView
    }
    
    
    func showPath(polyline: String) {
        let path = GMSPath(fromEncodedPath: polyline)
        DispatchQueue.main.async {
            let polylineDraw = GMSPolyline(path: path)
            polylineDraw.strokeWidth = 3.0
            polylineDraw.strokeColor = UIColor.red
            polylineDraw.map = self.mainView!.mapView
        }
        
    }
    
    
    
    
    // MARK: - GMSMapView Delegate methods:
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let placeVC = PlaceViewController()
        placeVC.place = self.allPlaces![0]
        self.present(placeVC, animated: true, completion: nil)
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let placeVC = PlaceViewController()
        let placeNavigationVC = UINavigationController(rootViewController: placeVC)
        placeVC.place = self.allPlaces![0]
        placeVC.userLocation = self.userCurrentLocation!
        self.present(placeNavigationVC, animated: true, completion: nil)
    }
    
    
    
}
