//
//  CourseTableViewController.swift
//  classmereApp
//
//  Created by Brandon Lee on 9/1/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit
import SwiftyJSON

class CourseTableViewController: UITableViewController, UISearchResultsUpdating {
    // Table Section Indexing Stuff
    let collation = UILocalizedIndexedCollation.currentCollation() as! UILocalizedIndexedCollation
    var sections: [[Course]] = []
    
    var allCourses: [Course] = [Course]() {
        didSet {
            let selector: Selector = "localizedTitle"
            sections = Array(count: collation.sectionTitles.count, repeatedValue: [])
            //let sortedObjects = collation.sortedArrayFromArray(allCourses, collationStringSelector: selector)
        }
    }
    var searchArray: [Course] = [Course]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        println("IN - viewDidLoad()")
        super.viewDidLoad()
        retrieveCourses()
        configureView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        println("IN - configureView()")
        tableView.rowHeight = 50
        
        // Search Controller Initialization
        self.resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        resultSearchController.searchBar.placeholder = "Search by Abbreviation"
        self.tableView.tableHeaderView = resultSearchController.searchBar
        definesPresentationContext = true
    }
    
    func retrieveCourses() {
        println("IN - retrieveCourses()")
        APIService.getAllCourses() { (data) -> Void in
            for courseIndex in data {
                var course: Course = Course(courseJSON: courseIndex.1)
                self.allCourses.append(course)
                println("Course Index: " + String(self.allCourses.count))
            }
            
            self.sortAllCourses()
        }
    }
    
    func sortAllCourses() {
        println("IN - sortAllCourses()")
        allCourses.sort() {$0.abbr < $1.abbr}
        self.tableView.reloadData()
    }
    
    // MARK: - Search
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        println("IN - updateSearchResultsForSearchController()")
        self.searchArray.removeAll(keepCapacity: false)
        
        let searchQuery = searchController.searchBar.text
        
        println("searchQuery: ")
        println(searchQuery)
        
        var filteredArray = allCourses.filter() { $0.abbr?.rangeOfString(searchQuery, options: .CaseInsensitiveSearch) != nil }
        
        self.searchArray = filteredArray as [Course]
        println("searchArray: " + String(stringInterpolationSegment: searchArray))
    }
    
    // MARK: - Table View Data Source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        println("IN - numberOfSectionsInTableView()")
        // Return the number of sections.
        return 1//self.sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("IN - numberOfRowsInSection()")
        // Return the number of rows in the section.
        
        // Search controller stuff
        if self.resultSearchController.active {
            return self.searchArray.count
        } else {
            return allCourses.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("IN - cellForRowAtIndexPath()")
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! CourseTableViewCell
        
        // Search controller stuff
        if self.resultSearchController.active {
            let searchCourseCell = searchArray[indexPath.row]
            
            cell.abbrLabel?.text = searchCourseCell.abbr
            cell.titleLabel?.text = searchCourseCell.title
            
        } else {
            let theCourseCell = allCourses[indexPath.row]
            
            cell.abbrLabel?.text = theCourseCell.abbr
            cell.titleLabel?.text = theCourseCell.title
        }

        return cell
    }
    
    /*// New Stuff for tableView sections
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collation.sectionTitles[section] as? String
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        return collation.sectionIndexTitles
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return collation.sectionForSectionIndexTitleAtIndex(index)
    }
    */

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        // Search Controller stuff
        // TODO: Implement this better
        if segue.identifier == "showCourse" {
            var course: Course
            if let indexPath = tableView.indexPathForSelectedRow() {
                if resultSearchController.active {
                    course = searchArray[indexPath.row]
                } else {
                    course = allCourses[indexPath.row]
                }
                
                (segue.destinationViewController as! CourseDetailViewController).detailCourse = course
            }
        }
    }
}
