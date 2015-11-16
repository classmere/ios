//
//  AppDelegate.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/25/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
            // Split view
            guard let splitViewController = self.window!
                .rootViewController as? UISplitViewController else {
                    fatalError("No SplitVC found during app initialization")
            }
            guard let navigationController = splitViewController.viewControllers
                .last as? UINavigationController else {
                    fatalError("No NavigationController found during app initialization")
            }
            navigationController.topViewController?.navigationItem
                .leftBarButtonItem = splitViewController.displayModeButtonItem()
            splitViewController.delegate = self
            return true
    }

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController,
        collapseSecondaryViewController secondaryViewController: UIViewController,
        ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
            return false
    }

}
