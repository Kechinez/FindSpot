//
//  CustomTabBarController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 20.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mainMapWindowNavVC = UINavigationController(rootViewController: MapViewController())
        mainMapWindowNavVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        //mapVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        
        let placesWindowNavVC = UINavigationController(rootViewController: AddNewPlaceViewController())
        //let placesVC = PlacesViewController()
        placesWindowNavVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let favouriteNavVC = UINavigationController(rootViewController: FavoritesViewController())
        //let favoritesVC = FavoritesViewController()
        favouriteNavVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 2)
        
        let tabBarArray = [mainMapWindowNavVC, placesWindowNavVC, favouriteNavVC]
        
        self.viewControllers = tabBarArray
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}
