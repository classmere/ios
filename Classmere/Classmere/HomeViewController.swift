//
//  HomeViewController.swift
//  Classmere
//
//  Created by Brandon Lee on 8/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import PureLayout
import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {
    
    var homeView: HomeView!
    var didSetupConstraints = false
    
    var tableView: UITableView!
    var courses = [Course]()
    var currentRequest: Request?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Classmere"
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .Plain, target: nil, action: nil)
        homeView = HomeView.newAutoLayoutView()
        tableView = homeView.tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        homeView.searchBar.delegate = self
        self.view.addSubview(homeView)
        self.view.setNeedsUpdateConstraints()
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
    
    // MARK: - Layout
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            homeView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
            homeView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
            homeView.autoPinEdgeToSuperviewEdge(.Leading)
            homeView.autoPinEdgeToSuperviewEdge(.Trailing)
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: UITableView Delegate and Datasource
    
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
            cell.iconLabel.text = EmojiFactory.emojiFromCourseType(course.subjectCode)
            cell.titleLabel.text = course.title
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(CourseViewController(course: courses[indexPath.row]), animated: true)
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {

    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        courses.removeAll()
        self.tableView.reloadData()
        homeView.dismissSearchBar(searchBar)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            courses.removeAll()
            self.tableView.reloadData()
        } else {
            fetchSearchResults(searchText) {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        tableView.keyboardDismissMode = .OnDrag
    }
}
