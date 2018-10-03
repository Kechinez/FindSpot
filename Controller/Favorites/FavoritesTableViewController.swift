//
//  FavoritesTableViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 22.06.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class FavoritesTableViewController: UITableViewController, UITabBarControllerDelegate {
    var favorites: [Place]?
    var userCurrentLocation: CLLocationCoordinate2D?
    
    //MARK: ViewController's life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Favorite spots"
        if let navogationcontroller = self.tabBarController {
            navogationcontroller.delegate = self
        }
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = .white
        self.tableView.backgroundView = FavoritesView(frame: tableView.frame)
        
        DataBaseManager.shared.getUserFavorites() { [weak self] (tempFavorites) in
            switch tempFavorites {
            case  .Success(let favorites):
                self?.favorites = favorites
                self?.tableView.reloadData()
            case .Failure(let error):
                guard let vc = self else { return }
                ErrorManager.shared.showErrorMessage(with: error, shownAt: vc)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }
    
}


// MARK: - TableView data source
extension FavoritesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let favorites = self.favorites {
            return favorites.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        if favorites != nil {
            cell.textLabel?.text = self.favorites![indexPath.row].placeName
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont(name: "OpenSans", size: 18)
            cell.backgroundColor = .clear
            cell.selectionStyle = .blue
        }
        return cell
    }
}

//MARK: - TableView delegate
extension FavoritesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userLocation = userCurrentLocation, let place = favorites?[indexPath.row] else { return }
        let placeVC = PlaceViewController()
        placeVC.userLocation = userLocation
        placeVC.place = place
        navigationController?.pushViewController(placeVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var place = self.favorites![indexPath.row]
            DataBaseManager.shared.deleteDatabaseValue(with: place.stringLatitude)
        }
    }
}
