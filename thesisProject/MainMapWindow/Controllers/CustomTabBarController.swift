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

        let mainMapWindowNavVC = MapViewController()//UINavigationController(rootViewController: MapViewController())
        //self.customizeNavigationController(with: mainMapWindowNavVC)
        
        mainMapWindowNavVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)

        let favouriteNavVC = FavoritesViewController() //UINavigationController(rootViewController: FavoritesViewController())
        //self.customizeNavigationController(with: favouriteNavVC)
        favouriteNavVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        
        let tabBarArray = [mainMapWindowNavVC, favouriteNavVC]
        self.viewControllers = tabBarArray
    
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.tabBarController?.navigationController {
            self.customizeNavigationController(with: navigationController)
        }
    }
    
    
    
    func customizeNavigationController(with navigationController: UINavigationController) {
        
        let navigationBarAppearace = navigationController.navigationBar
        navigationBarAppearace.tintColor =  _ColorLiteralType(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        navigationBarAppearace.barTintColor = .white
        
        if let navFont = UIFont(name: "Helvetica", size: 18) {
            let navBarAttributesDictionary: [NSAttributedStringKey: Any] = [
                NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white,
                NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): navFont]
            
            navigationBarAppearace.titleTextAttributes = navBarAttributesDictionary
        }
        
    }
    
    
    
}
