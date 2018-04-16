//
//  FavoritesViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 20.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import Firebase
class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var favorites: [Place]?
    private var tableView: UITableView?
    var userDatabaseRef: DatabaseReference?
    private let databaseManager = DataBaseManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.databaseManager.getUserFavorites(with: self.userDatabaseRef!) { (tempFavorites) in
            guard let favorites = tempFavorites else { return }
            self.favorites = favorites
            self.tableView!.reloadData()
            
        }
        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let favoriteView = FavoritesView(frame: CGRect(x: 0, y: topBarHeight, width: self.view.bounds.width, height: self.view.bounds.height - topBarHeight))
        self.view.addSubview(favoriteView)
        self.tableView = favoriteView.tableView!
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
    }
    
    
    
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites!.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = self.favorites![indexPath.row].placeName
        cell.textLabel?.textColor = .white
        
        return cell
    }
    

    

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var place = self.favorites![indexPath.row]
            self.databaseManager.deleteDatabaseValue(at: self.userDatabaseRef!, with: place.coordinatesInString)
            
            //            let referenceForDeleting = self.databaseManager.recreatePlaceDataReference(from: self.userDatabaseRef!, and: place.coordinatesInString)
//            referenceForDeleting.removeValue()
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    

}
