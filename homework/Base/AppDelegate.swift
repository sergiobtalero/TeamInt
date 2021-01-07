//
//  AppDelegate.swift
//  homework
//
//  Created by Alex Rouse on 4/7/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "TripsList", bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController() as! TripsListViewController
        self.window?.rootViewController = UINavigationController(rootViewController: initialViewController)
        self.window?.makeKeyAndVisible()

        return true
    }
}

