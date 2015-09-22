//
//  Course.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/25/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Course {
    let title: String?
    let abbr: String?
    let credits: [Int]?
    let description: String?
    
    var courseSections = [CourseSection]()
    
    init(courseJSON: JSON) {
        title = courseJSON["title"].string as String?
        abbr = courseJSON["abbr"].string as String?
        credits = courseJSON["credits"].arrayObject as! [Int]?
        description = courseJSON["description"].string as String?
        
        // If sections exist, for each section in JSON array, create a CourseSection object
        if let sectionArray = courseJSON["sections"].array {
            for theSection in sectionArray {
                let courseSection = CourseSection(sectionJSON: theSection)
                courseSections.append(courseSection)
            }
        }
    }
}
