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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        Alamofire.request(.GET, "http://httpbin.org/get")
            .responseJSON {(request, response, JSON, error) in
                println(JSON)
        }
        */
        
        APIService.getAllCourses() { (json) -> Void in
            println(json)
        }
        
        APIService.getCourseByAbbr("CS%20161")
        APIService.derp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
