//
//  SectionViewController.swift
//  classmereApp
//
//  Created by Brandon Lee on 9/7/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit

class SectionViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var instructorLabel: UILabel?
    @IBOutlet weak var dayLabel: UILabel?
    @IBOutlet weak var startTimeLabel: UILabel?
    @IBOutlet weak var endTimeLabel: UILabel?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var termLabel: UILabel?
    @IBOutlet weak var sectionNumberLabel: UILabel?
    @IBOutlet weak var crnLabel: UILabel?
    @IBOutlet weak var typeLabel: UILabel?
    @IBOutlet weak var statusLabel: UILabel?
    @IBOutlet weak var capacityLabel: UILabel?
    @IBOutlet weak var currentEnrolledLabel: UILabel?
    @IBOutlet weak var availableSpotsLabel: UILabel!
    @IBOutlet weak var restrictionsLabel: UILabel?
    
    var detailSection: CourseSection? {
        didSet { configureView() }
    }
    
    func configureView() {
        self.title = "Course Details"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize.height = 700
        scrollView.contentOffset = CGPoint(x: 0, y: 75)
        
        if let section = detailSection as CourseSection! {
            self.instructorLabel?.text = section.instructor
            self.dayLabel?.text = section.days
            self.startTimeLabel?.text = String(section.startTime)
            self.endTimeLabel?.text = String(section.endTime)
            
            // TODO: Sometimes finds nil, do safe checking
            if section.buildingCode != nil && section.roomNumber != nil {
                self.locationLabel?.text = section.buildingCode! + " " + section.roomNumber!
            }
            
            
            self.termLabel?.text = section.term
            //self.sectionNumberLabel?.text = String(section.sectionNumber!)
            self.crnLabel?.text = String(stringInterpolationSegment: section.crn!)
            self.typeLabel?.text = section.type
            self.statusLabel?.text = section.status
            self.capacityLabel?.text = String(stringInterpolationSegment: section.capacity!)
            self.currentEnrolledLabel?.text = String(stringInterpolationSegment: section.currentEnrollment!)
            self.availableSpotsLabel?.text = String(section.capacity! - section.currentEnrollment!)
            self.restrictionsLabel?.text = section.restrictions
        }
    }
    
    @IBAction func exitButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
