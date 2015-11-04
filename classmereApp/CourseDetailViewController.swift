//
//  CourseDetailViewController.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/25/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CourseDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var creditsLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    @IBOutlet weak var tableView: UITableView!
    
    var detailCourse: Course? {
        didSet { configureView() }
    }
    
    var course: Course?
    
    func configureView() {
        self.title = detailCourse?.abbr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
            
        if let subjectCode = course?.subjectCode, courseNumber = course?.courseNumber {
            APIService.getCourseBySubjectCode(subjectCode,
                courseNumber: courseNumber) { courseJSON in
                    
                    self.course = Course(courseJSON: courseJSON)
                    // Set labels
                    self.titleLabel?.text = self.course!.title!
                    self.descriptionLabel?.text = self.course!.description!
                    
                    if let creditsArray = self.course!.credits {
                        let minimumCredit = creditsArray[0] as Int
                        self.creditsLabel?.text = String(minimumCredit)
                    }
                    self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.flashScrollIndicators()
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return course?.courseSections.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCellWithIdentifier("SectionCell", forIndexPath: indexPath) as! SectionTableViewCell
        if let section = course?.courseSections[indexPath.row] {
            cell.termLabel?.text = section.term
            cell.startTimeLabel?.text = String(section.startTime)
            cell.endTimeLabel?.text = String(section.endTime)
            cell.instructorLabel?.text = section.instructor
        }
        
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSection" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let section = course?.courseSections[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! SectionViewController
                controller.detailSection = section
            }
        }
    }
    @IBAction func exitButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
