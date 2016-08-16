//
//  HomeView.swift
//  Classmere
//
//  Created by Brandon Lee on 8/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import PureLayout

public class HomeView: UIView {
    
    var searchButton: UIButton!
    
    var didSetupConstraints = false
    
    var horizontalLayoutConstraints: NSArray?
    var verticalLayoutConstraints: NSArray?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        searchButton = UIButton()
        searchButton.frame = CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, 100, 50)
        searchButton.backgroundColor = UIColor.blackColor()
        searchButton.setTitle("Search", forState: .Normal)
        searchButton.addTarget(HomeViewController(), action: #selector(HomeViewController.buttonTapped), forControlEvents: .TouchUpInside)
        self.addSubview(searchButton)
//        self.setNeedsUpdateConstraints()
    }
    
//    override public func updateConstraints() {
//        print("This is called")
//        if !didSetupConstraints {
//            
//        }
//    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
