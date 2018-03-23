//
//  MapViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 20.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps
class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    private var locationManager: CLLocationManager?
    private var mapView: MapView?
    //private let url = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/distancematrix/json?origins=61.686151,27.298954&destinations=61.681658,27.264764&mode=walking&language=en&key=AIzaSyAmV1T_J6_noWuMYBJukYv3-eDBvhr3zmY")
        
        TempNetManager.shared.getData(url: url!) { (data) in
           
            let result = DataConverter(data: data)
            if let totalResult = result {
                print("1@@@@@@@@@ total time is \(totalResult.time!) @@@@@@")
            } else {
                print("2@@@@@@@@@@ ERROR @@@@@@@@@@@")
            }
            
        }
        
        
        mapView = MapView(frame: CGRect(x: 0, y: 20, width: self.view.bounds.width, height: self.view.bounds.height))
        mapView!.delegate = self
        self.view.addSubview(mapView!)
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=61.686151,27.298954&destination=61.681658,27.264764&key=AIzaSyAmV1T_J6_noWuMYBJukYv3-eDBvhr3zmY")
        TempNetManager.shared.getRoutes(url: url!) { (route) in
            let result = DataConverter(jsonArray: route)
            if let result = result {
                self.showPath(polyline: result.polyline!)
            }
        }
    }
    
    func showPath(polyline: String) {
        let path = GMSPath(fromEncodedPath: polyline)
        DispatchQueue.main.async { 
            let polylineDraw = GMSPolyline(path: path)
            polylineDraw.strokeWidth = 3.0
            polylineDraw.strokeColor = UIColor.red
            polylineDraw.map = self.mapView
        }
        
    }

}
