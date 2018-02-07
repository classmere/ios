//
//  AppDelegate.swift
//  Classmere
//
//  Created by Brandon Lee on 8/8/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let homeViewController = HomeViewController(nibName: nil, bundle: nil)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.navigationBar.isTranslucent = false
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }

}
