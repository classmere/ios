//
//  TodayViewController.swift
//  classmere
//
//  Created by Rutger Farry on 10/21/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//

import UIKit

class TodayViewController: UITableViewController {
    
    let todayViewModel = TodayViewModel()
    var detailViewController: DetailViewController? = nil
    let cellColors = [
        UIColor(hue:0.02, saturation:0.64, brightness:0.95, alpha:1),
        UIColor(hue:0.51, saturation:0.81, brightness:0.91, alpha:1),
        UIColor(hue:0.45, saturation:0.89, brightness:0.84, alpha:1)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch courses
        todayViewModel.fetchCourseData([("PAC", 296), ("ECE", 271), ("Z", 477)]) {
            self.tableView.reloadData()
            
            let sections  = self.todayViewModel.courses.map({ course in
                return course.courseSections[0]
            })
            self.todayViewModel.fetchBuildingDataForSections(sections) {
                self.tableView.reloadData()
            }
        }
        
        // Split view controller
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                let course = todayViewModel.courses[indexPath.section]
                
                controller.detailViewModel = DetailViewModel(course: course)
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return todayViewModel.courses.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 122
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",
            forIndexPath: indexPath) as! TodayTableViewCell
        let course = todayViewModel.courses[indexPath.section]
        cell.populateWithCourse(course)
        cell.contentView.backgroundColor = cellColors[indexPath.section]
        return cell
    }
    
}
