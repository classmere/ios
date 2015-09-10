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
        didSet {
            configureView()
        }
    }
    
    // TODO: Get the tableview working
    var course: Course?
    
    func configureView() {
        self.title = detailCourse?.abbr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
        tableView.delegate = self
        tableView.dataSource = self
        
        if let theCourse: Course = self.detailCourse as Course! {
            
            var abbr: String = theCourse.abbr!
            
            APIService.getCourseByAbbr(abbr) { (data) -> Void in
                println("APIService()")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        println("IN 2 numberOfSections...")
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        println("IN 2 numberofRowsInSection()")
        // FIXME: Problem with data not concurrently being retrieved in time
        //println(course.sections.count)
        return course?.sections.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCellWithIdentifier("SectionCell", forIndexPath: indexPath) as! SectionTableViewCell
        if let section = course?.sections[indexPath.row] {
            cell.termLabel?.text = section.term
            cell.timeLabel?.text = section.startTime
            cell.instructorLabel?.text = section.instructor
        }
        
        return cell
    }
}
