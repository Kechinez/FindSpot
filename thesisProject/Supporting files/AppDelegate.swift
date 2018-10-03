//
//  AppDelegate.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 20.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps

let googleApiKey = "AIzaSyAmV1T_J6_noWuMYBJukYv3-eDBvhr3zmY"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(googleApiKey)
        FirebaseConfiguration.shared.setLoggerLevel(FirebaseLoggerLevel.min)
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
        
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        UITabBar.appearance().tintColor = .white
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        if let navFont = UIFont(name: "Comfortaa", size: 22) {
            let navBarAttributesDictionary: [NSAttributedStringKey: Any] = [
                NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white,
                NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): navFont]
            UINavigationBar.appearance().titleTextAttributes = navBarAttributesDictionary
        }
        
        if let barItemFont = UIFont(name: "OpenSans", size: 18) {
            let barItemAttributesDictionary: [NSAttributedStringKey: Any] = [
                NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white,
                NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): barItemFont]
            UIBarButtonItem.appearance().setTitleTextAttributes(barItemAttributesDictionary, for: .normal)
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

