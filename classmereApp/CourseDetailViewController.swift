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

class CourseDetailViewController: UIViewController {

    var detailCourse: Course? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let course: Course = self.detailCourse as Course! {
            println("Detail Item Course: " + course.abbr!)
            var theAbbr = course.abbr!
            println(course.sections)
            
            //FIXME: Nil unwrapped optional for Abbr
            APIService.getCourseByAbbr("CS%20161") { (data) -> Void in
                var courseWithSections = Course(courseJSON: data)
                
                // This is a test for grabbing general data from course
                println(courseWithSections.title!)
                
                // This is a test for grabbing data from a courses's section
                println("Section term: " + courseWithSections.sections[0].term!)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
