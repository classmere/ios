//
//  FirstLaunchViewController.swift
//  classmereApp
//
//  Created by Brandon Lee on 9/28/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

class FirstLaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if firstLaunch {
            print("Client has launched before")
        } else {
            print("First launch. Setting NSUserDefaults(FirstLaunch).")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            self.performSegueWithIdentifier("firstLaunch", sender: self)
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func startButtonPress(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
