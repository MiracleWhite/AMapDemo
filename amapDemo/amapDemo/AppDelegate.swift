//
//  AppDelegate.swift
//  amapDemo
//
//  Created by Miracle on 2021/8/24.
//

import UIKit
import AMapFoundationKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AMapServices.shared().apiKey = "7e0319d6d6f7c9019c302edd3e2db0b0"
        
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds
        
        self.window?.rootViewController = UINavigationController.init(rootViewController: ViewController())
        self.window?.makeKeyAndVisible()
        
        return true
    }

    


}

