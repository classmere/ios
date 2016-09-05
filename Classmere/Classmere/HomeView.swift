//
//  HomeView.swift
//  Classmere
//
//  Created by Brandon Lee on 8/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import PureLayout

class HomeView: UIView {
    
    let darkColor: UIColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    let lightBlueColor: UIColor = UIColor(red:0.24, green:0.73, blue:0.94, alpha:1.0)
    
    var didSetupConstraints = false
    
    var searchBarTop = false
    var searchBar: UISearchBar!
    var searchButton: UIButton!
    var tableView: UITableView!
    var searchButtonWidthConstraint: NSLayoutConstraint?
    var searchButtonEdgeConstraint: NSLayoutConstraint?
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    // MARK: - Setup
    
    func setupViews() {
        self.backgroundColor = .whiteColor()
        setupSearchBar()
        setupSearchButton()
        setupTableView()
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar.newAutoLayoutView()
        searchBar.showsCancelButton = true
        searchBar.alpha = 0
        searchBar.backgroundColor = darkColor
        searchBar.barTintColor = darkColor
        searchBar.tintColor = lightBlueColor
        
        let textFieldInsideSearchBar = searchBar.valueForKey("searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = darkColor
        textFieldInsideSearchBar?.textColor = .whiteColor()
        
        let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: lightBlueColor]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String : AnyObject], forState: UIControlState.Normal)

        addSubview(searchBar)
    }
    
    func setupSearchButton() {
        searchButton = UIButton(type: .Custom)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(HomeView.searchClicked(_:)), forControlEvents: .TouchUpInside)
        searchButton.setTitle("Search", forState: .Normal)
        searchButton.backgroundColor = darkColor
        searchButton.layer.cornerRadius = 20
        addSubview(searchButton)
    }
    
    func setupTableView() {
        tableView = UITableView.newAutoLayoutView()
        tableView.alpha = 0
        addSubview(tableView)
    }
    
    // MARK: - Layout
    
    override func updateConstraints() {
        if !didSetupConstraints {
            searchBar.autoAlignAxisToSuperviewAxis(.Vertical)
            searchBar.autoSetDimension(.Height, toSize: 50)
            searchBar.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
            searchBar.autoPinEdgeToSuperviewEdge(.Top)

            searchButton.autoSetDimension(.Height, toSize: 60)
            searchButton.autoAlignAxisToSuperviewAxis(.Vertical)
            
            tableView.autoAlignAxisToSuperviewAxis(.Vertical)
            tableView.autoPinEdgeToSuperviewEdge(.Leading)
            tableView.autoPinEdgeToSuperviewEdge(.Trailing)
            tableView.autoPinEdgeToSuperviewEdge(.Bottom)
            tableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: searchBar)
            
            didSetupConstraints = true
        }
        
        searchButtonWidthConstraint?.autoRemove()
        searchButtonEdgeConstraint?.autoRemove()
        
        if searchBarTop {
            searchButtonWidthConstraint = searchButton.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
            searchButtonEdgeConstraint = searchButton.autoPinEdgeToSuperviewEdge(.Top)
        } else {
            searchButtonWidthConstraint = searchButton.autoSetDimension(.Width, toSize: 200)
            searchButtonEdgeConstraint = searchButton.autoAlignAxisToSuperviewAxis(.Horizontal)
        }
        
        super.updateConstraints()
    }
    
    // MARK: - User Interaction
    
    func searchClicked(sender: UIButton!) {
        showSearchBar(searchBar)
    }
    
    // MARK: - Animation
    
    func showSearchBar(searchBar: UISearchBar) {
        searchBarTop = true
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
        
        UIView.animateWithDuration(0.3, animations: {
                                    searchBar.becomeFirstResponder()
                                    self.layoutIfNeeded()
            }, completion: { finished in
                UIView.animateWithDuration(0.2,
                    animations: {
                        searchBar.alpha = 1
                        self.tableView.alpha = 1
                        self.searchButton.alpha = 0
                        self.searchButton.layer.cornerRadius = 0
                    }
                )
            }
        )
    }
    
    func dismissSearchBar(searchBar: UISearchBar) {
        searchBarTop = false
        
        UIView.animateWithDuration(0.2,
                                   animations: {
                                    searchBar.alpha = 0
                                    self.tableView.alpha = 0
                                    self.searchButton.alpha = 1
                                    self.searchButton.layer.cornerRadius = 20
            }, completion: { finished in
                self.setNeedsUpdateConstraints()
                self.updateConstraintsIfNeeded()
                UIView.animateWithDuration(0.3,
                    animations: {
                        searchBar.resignFirstResponder()
                        self.layoutIfNeeded()
                    }
                )
            }
        )
    }
}
