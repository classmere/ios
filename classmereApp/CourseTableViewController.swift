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
        println("IN viewDidLoad()")
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
        println("IN configureView")
        tableView.rowHeight = 50
    }
    
    func retrieveCourses() {
        println("IN retrieveCourses()")
        APIService.getAllCourses() { (data) -> Void in
            for courseIndex in data {
                var course: Course = Course(courseJSON: courseIndex.1)
                println("The courseIndex: " + courseIndex.0)
                self.allCourses.append(course)
                println("allCourses Length")
                println(self.allCourses.count)
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
        println("IN numberOfSections...")
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        println("IN numberofRowsInSection()")
        println(allCourses.count)
        return allCourses.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! CourseTableViewCell
        println("IN - cellForRowAtIndexPath()")
        // Configure the cell...
        let theCourseCell = allCourses[indexPath.row]

        cell.abbrLabel?.text = theCourseCell.abbr
        cell.titleLabel?.text = theCourseCell.title
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }

    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
