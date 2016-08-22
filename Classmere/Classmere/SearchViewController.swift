//
//  SearchViewController.swift
//  Classmere
//
//  Created by Brandon Lee on 8/15/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomSearchControllerDelegate {
    
    var tableView: UITableView! = UITableView()
    var courses = [Course]()
    var currentRequest: Request?
    
    var searchController: UISearchController!
    var customSearchController: CustomSearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
        self.view.addSubview(tableView)
        configureCustomSearchController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Custom functions
    
    func fetchSearchResults(query: String, completed: () -> Void) {
        if let currentRequest = currentRequest {
            currentRequest.cancel()
        }
        
        currentRequest = APIService.searchCourse(query) { coursesJSON in
            self.courses.removeAll(keepCapacity: true)
            for (_, courseJSON) in coursesJSON {
                let course = Course(courseJSON: courseJSON)
                self.courses.append(course)
                completed()
            }
        }
    }
    
    func configureCustomSearchController() {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, tableView.frame.size.width, 50.0))
        customSearchController.customSearchBar.placeholder = "Search"
        tableView.tableHeaderView = customSearchController.customSearchBar
        customSearchController.customDelegate = self
        
    }
    
    // MARK: UITableView Delegate and Datasource functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell: SearchCell = tableView.dequeueReusableCellWithIdentifier("SearchCell") as? SearchCell {
            let course = courses[indexPath.row]
            cell.titleLabel.text = course.title?.capitalizedString
            cell.iconLabel.text = "🏫"
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(tableView.cellForRowAtIndexPath(indexPath)?.description)
    }

    // MARK: CustomSearchControllerDelegate functions
    
    func didStartSearching() {

    }
    
    func didTapOnSearchButton() {
        
    }
    
    func didTapOnCancelButton() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didChangeSearchText(searchText: String) {
        if searchText == "" {
            courses.removeAll()
        } else {
            fetchSearchResults(searchText) {
                self.tableView.reloadData()
            }
        }
    }
}
