//
//  CourseTableViewController.swift
//  classmereApp
//
//  Created by Brandon Lee on 9/1/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit
import SwiftyJSON

class CourseTableViewController: UITableViewController {
    
    var allCourses: [Course] = [Course]()
 
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
    }
    
    func retrieveCourses() {
        APIService.getAllCourses() { (data) -> Void in
            for courseIndex in data {
                var course: Course = Course(courseJSON: courseIndex.1)
                self.allCourses.append(course)
            }
            
            self.filterAllCourses()
        }
    }
    
    func filterAllCourses() {
        allCourses.sort() {$0.abbr < $1.abbr}
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return allCourses.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! CourseTableViewCell
        let theCourseCell = allCourses[indexPath.row]

        cell.abbrLabel?.text = theCourseCell.abbr
        cell.titleLabel?.text = theCourseCell.title
        
        return cell
    }

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
