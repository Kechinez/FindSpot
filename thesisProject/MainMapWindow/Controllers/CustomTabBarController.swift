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

        let mapVC = MapViewController()
        mapVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        
        let placesVC = PlacesViewController()
        placesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 2)
        
        let tabBarArray = [mapVC, placesVC, favoritesVC]
        
        self.viewControllers = tabBarArray
    
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
