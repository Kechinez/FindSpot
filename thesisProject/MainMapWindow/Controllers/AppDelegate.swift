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
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

