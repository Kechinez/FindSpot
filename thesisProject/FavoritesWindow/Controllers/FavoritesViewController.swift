//
//  FavoritesViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 20.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate {

    var favorites: [Place]?
    private var tableView: UITableView?
    var userCurrentLocation: CLLocationCoordinate2D?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Favorite spots"
        if let navogationcontroller = self.tabBarController {
            navogationcontroller.delegate = self
        }
        DataBaseManager.shared.getUserFavorites() { (tempFavorites) in
            switch tempFavorites {
            case  .Success(let favorites):
                self.favorites = favorites
                self.tableView!.reloadData()
            case .Failure(let error):
                ErrorManager.shared.showErrorMessage(with: error, shownAt: self)
            }
            
        }
        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let favoriteView = FavoritesView(frame: CGRect(x: 0, y: topBarHeight, width: self.view.bounds.width, height: self.view.bounds.height - topBarHeight))
        
        self.tableView = favoriteView.tableView!
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.view.addSubview(favoriteView)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let favorites = self.favorites {
            return favorites.count
        } else {
            return 0
        }
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let navigationController = self.navigationController {
            let placeVC = PlaceViewController()
            placeVC.userLocation = self.userCurrentLocation!
            placeVC.place = self.favorites![indexPath.row]
            navigationController.pushViewController(placeVC, animated: true)
        }
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        cell.textLabel?.text = self.favorites![indexPath.row].placeName
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "OpenSans", size: 18)
        cell.backgroundColor = .clear
        cell.selectionStyle = .blue
        
        return cell
    }
    

    

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var place = self.favorites![indexPath.row]
            DataBaseManager.shared.deleteDatabaseValue(with: place.stringLatitude)
        }
    }
    

    

}
