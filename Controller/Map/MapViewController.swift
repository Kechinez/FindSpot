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
class MapViewController: UIViewController, CLLocationManagerDelegate, UITabBarControllerDelegate {
    
    unowned var mainView: MainMapView {
        return self.view as! MainMapView
    }
    var userCurrentLocation: CLLocationCoordinate2D?
    private var userCurrentCity: String?
    private var allPlaces: [Place]? = []
    var favorites: [Place]?
    private var userDatabaseRef: DatabaseReference?
    
    
    //MARK: - ViewController's lifecycle methods
    override func loadView() {
        self.view = MainMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "FindSpot"
        self.mainView.setBarButtonItems(linkedWith: self)
        self.mainView.mapView.delegate = self
        self.mainView.searchTextField.delegate = self
        if let tabBarController = self.tabBarController {
            tabBarController.delegate = self
        }
        guard let currentUser = Auth.auth().currentUser else { return }
        self.userDatabaseRef = Database.database().reference(withPath: "users").child(String(currentUser.uid)).child("favorites")
        DataBaseManager.shared.userRef = self.userDatabaseRef
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        let tempCoordinate = CLLocationCoordinate2D(latitude: 59.882023, longitude: 30.339113) //  temp coordinates should be used to emulate Saint-P current location
        self.userCurrentLocation = tempCoordinate
        self.mainView.setMapCameraPosition(using: tempCoordinate, with: 15.0)
        
        GoogleApiRequests.shared.getAddressFromCoordinates(tempCoordinate) { [weak self] (city) in
            switch city {
            case  .Success(let foundCity):
                self?.userCurrentCity = foundCity.cityName
            case .Failure(let error):
                guard let vc = self else { return }
                ErrorManager.shared.showErrorMessage(with: error, shownAt: vc)
                return
            }
            guard let userCurrentCity = self?.userCurrentCity else { return }
            DataBaseManager.shared.getPlacesWithin(city: userCurrentCity) { (places) in
                switch places {
                case  .Success(let places):
                    self?.allPlaces = places
                    for place in places {
                        self?.showFoundPlace(with: place.coordinates, info: place.placeName)
                    }
                case .Failure(let error):
                    guard let vc = self else { return }
                    ErrorManager.shared.showErrorMessage(with: error, shownAt: vc)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }
    
    // MARK: - TabBarControllerDelegate methods
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let favoritesVC = viewController as? UINavigationController else { return }
        guard let vc = favoritesVC.childViewControllers.first as? FavoritesTableViewController else { return }
        guard let userLocation = userCurrentLocation else { return }
        vc.userCurrentLocation = userLocation
    }
    
    // MARK: - NavigationBar's buttons action methods:
    @objc func addNewPlace() {
        if let navigationController = self.navigationController {
            let newPlaceVC = AddNewPlaceViewController()
            newPlaceVC.currentUserLocation = self.userCurrentLocation
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
    
// MARK: - Methods showing map's elements:
    func showFoundPlace(with coordinates: CLLocationCoordinate2D, info: String) {
        let marker = GMSMarker()
        marker.position = coordinates
        marker.title = info
        marker.map = self.mainView.mapView
    }
    
}

//MARK: - UITextFieldDelegate
extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.count > 2 {
            guard let userInputText = textField.text else { return false }
            
            DataBaseManager.shared.getPlacesWithin(city: userInputText) { [weak self] (places) in
                switch places {
                case  .Success(let places):
                    self?.allPlaces = places
                    let examplePlaceLocation = places[0].coordinates
                    self?.mainView.setMapCameraPosition(using: examplePlaceLocation, with: 11.0)
                    for place in places {
                        self?.showFoundPlace(with: place.coordinates, info: place.placeName)
                    }
                case .Failure(let error):
                    guard let vc = self else { return }
                    ErrorManager.shared.showErrorMessage(with: error, shownAt: vc)
                }
            }
        }
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let places = allPlaces else { return false }
        for (index, place) in places.enumerated() {
            guard marker.position.latitude == place.coordinates.latitude,
                marker.position.longitude == place.coordinates.longitude  else { continue }
            
            let placeVC = PlaceViewController()
            placeVC.place = places[index]
            if let userLocation = userCurrentLocation {
                placeVC.userLocation = userLocation
            }
            guard let navigationVC = self.navigationController else { return true }
            navigationVC.pushViewController(placeVC, animated: true)
        }
        return true
    }
}

