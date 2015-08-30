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
        /*
        APIService.getCourseByAbbr("CS%20161") { (data) -> Void in
            if let theTitle = data["title"].string {
                println(theTitle)
            }
            println(data["title"])
        }
        */
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        APIService.getCourseByAbbr("CS%20161") { (data) -> Void in
            var theCourse = Course(courseJSON: data)
            self.titleLabel?.text = theCourse.title
        }
        
        /*
        APIService.getCourseByAbbr("CS%20161") { (data) -> Void in
            if let theTitle = data["title"].string {
                println(theTitle)
                self.titleLabel?.text = theTitle
            }
        }

        Alamofire.request(.GET, "http://httpbin.org/get")
            .responseJSON {(request, response, JSON, error) in
                println(JSON)
        }
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
