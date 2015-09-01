//
//  ViewController.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/25/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    var course: Course? {
        didSet {
            configureView()
        }
    }
    
    
    @IBOutlet weak var titleLabel: UILabel?
    
    func configureView() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        APIService.getCourseByAbbr("CS%20161") { (data) -> Void in
            var theCourse = Course(courseJSON: data)
            self.titleLabel?.text = theCourse.title
            
            // This is a test for grabbing general data from course
            println(theCourse.title!)
            
            // This is a test for grabbing data from a courses's section
            println("Section term: " + theCourse.sections[0].term!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
