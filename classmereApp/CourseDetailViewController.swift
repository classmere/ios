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
        
        if let theCourse: Course = self.detailCourse as Course! {
            
            let abbr: String = theCourse.abbr!
            
            APIService.getCourseByAbbr(abbr) { (data) -> Void in
                self.course = Course(courseJSON: data)
                
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
        print("IN - viewDidAppear")
        super.viewDidAppear(animated)
        self.tableView.flashScrollIndicators()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            cell.startTimeLabel?.text = section.startTime
            cell.endTimeLabel?.text = section.endTime
            cell.instructorLabel?.text = section.instructor
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showSection" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let section = course?.courseSections[indexPath.row]
                (segue.destinationViewController as! SectionViewController).detailSection = section
            }
        }
    }
}
