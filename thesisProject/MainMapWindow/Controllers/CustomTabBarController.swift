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

        let favouriteNavVC = UINavigationController(rootViewController: FavoritesViewController())
        favouriteNavVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        
        let tabBarArray = [mainMapWindowNavVC, favouriteNavVC]
        self.viewControllers = tabBarArray
    
    }

}
