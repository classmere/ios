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
    
    var allCourses: [Course] = [Course]()
    
    var searchArray: [Course] = [Course]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var resultSearchController = UISearchController()
    
    /* // Table Section Indexing Stuff
    let collation = UILocalizedIndexedCollation.currentCollation() as! UILocalizedIndexedCollation
    var sections: [[AnyObject]] = []
    
    {
        didSet {
            let selector: Selector = "localizedTitle"
            sections = Array(count: collation.sectionTitles.count, repeatedValue: [])
            
            let sortedObjects = collation.sortedArrayFromArray(allCourses, collationStringSelector: selector)
            for object in sortedObjects {
                let sectionNumber = collation.sectionForObject(object, collationStringSelector: selector)
                sections[sectionNumber].append(object)
            }
            
            self.tableView.reloadData()
        }
    }*/
 
    override func viewDidLoad() {
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
        tableView.rowHeight = 50
        
        // Search Controller Initilization
        self.resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.searchBarStyle = .Minimal
        resultSearchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = resultSearchController.searchBar
    }
    
    func retrieveCourses() {
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
        allCourses.sort() {$0.abbr < $1.abbr}
        self.tableView.reloadData()
    }
    
    // MARK: - Search
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.searchArray.removeAll(keepCapacity: false)
        
        //let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
        let searchPredicate = searchController.searchBar.text
        println("SearchPredicate: ")
        println(searchPredicate )
        
        
        //var filteredArray = allCourses.filter() { $0.abbr == searchPredicate }
        var filteredArray = allCourses.filter( { (course: Course) -> Bool in
            //println(course.abbr!)
            println(course.abbr! == searchPredicate)
            return course.abbr! == searchPredicate
        })
        
        
        println("filteredArray: " + String(stringInterpolationSegment: filteredArray))
        // let array: Array = (filteredArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        self.searchArray = filteredArray as [Course]
        println("searchArray: " + String(stringInterpolationSegment: searchArray))
    }
    
    // MARK: - Table View Data Source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1//self.sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        // Search controller stuff
        if self.resultSearchController.active {
            return self.searchArray.count
        } else {
            return allCourses.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
    
    /* // New Stuff for tableView sections
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
        if segue.identifier == "showCourse" {
            if let indexPath = tableView.indexPathForSelectedRow() {
                let course = allCourses[indexPath.row]
                (segue.destinationViewController as! CourseDetailViewController).detailCourse = course
            }
        }
    }
}
