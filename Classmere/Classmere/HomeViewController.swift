//
//  HomeViewController.swift
//  Classmere
//
//  Created by Brandon Lee on 8/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Classmere"
        let homeView: UIView = HomeView.init(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        self.view.addSubview(homeView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonTapped(sender:UIButton!) {
        print("BUTTON TAP")
    }
}
