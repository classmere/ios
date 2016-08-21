//
//  CustomSearchBar.swift
//  Classmere
//
//  Created by Brandon Lee on 8/15/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    override func drawRect(rect: CGRect) {
        if let index = indexOfTextFieldInSubviews() {
            let searchField: UITextField = (subviews[0] ).subviews[index] as! UITextField
            searchField.frame = CGRectMake(5.0, 5.0, frame.size.width - 10.0, frame.size.height - 10.0)
            searchField.font = UIFont(name: "Helvetica Neue", size: 16.0)!
            searchField.textColor = UIColor.orangeColor()
            searchField.backgroundColor = barTintColor
        }
        
        super.drawRect(rect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.frame = frame
        searchBarStyle = UISearchBarStyle.Prominent
        translucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func indexOfTextFieldInSubviews() -> Int! {
        var index: Int!
        let searchBarView = subviews[0]
        
        for subview in 0..<searchBarView.subviews.count {
            if searchBarView.subviews[subview].isKindOfClass(UITextField) {
                index = subview
                break
            }
        }
        
        return index
    }
}