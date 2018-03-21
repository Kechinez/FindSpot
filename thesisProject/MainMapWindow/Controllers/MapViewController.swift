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
        //let url = URL(fileURLWithPath: "https://maps.googleapis.com/maps/api/distancematrix/json?origins=61.686151,27.298954&destinations=61.681658,27.264764&mode=walking&language=en&key=AIzaSyAmV1T_J6_noWuMYBJukYv3-eDBvhr3zmY")
        TempNetManager.shared.getData(url: url!) { (data) in
           
            let result = DataConverter(data: data)
            if let totalResult = result {
                print("1@@@@@@@@@ total time is \(totalResult.time) @@@@@@")
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
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
