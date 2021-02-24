//
//  AppDelegate.swift
//  GradesGuru
//
//  Created by Superpower on 16/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()

        
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            
            
            print("uuid: \(uuid)")
            
            Usersdetails.device_ID = uuid
            let defaults = UserDefaults.standard
            
            
            if defaults.value(forKey: "device_ID") != nil {
                
                        
                window = UIWindow(frame: UIScreen.main.bounds)
                
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let viewController = storyboard.instantiateViewController(identifier: "HomePageVC")
                window?.rootViewController = viewController
                window?.makeKeyAndVisible()
                
                return true
             
            } else {
                
                defaults.set(Usersdetails.device_ID, forKey: "device_ID")
                
                window = UIWindow(frame: UIScreen.main.bounds)
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let viewController = storyboard.instantiateInitialViewController()
                window?.rootViewController = viewController
                window?.makeKeyAndVisible()
                return true
                    
            }
            
            
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

