//
//  Course.swift
//  Classmere
//
//  Created by Brandon Lee on 8/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 A model representation of a course at OSU.
 Reference Docs - https://github.com/classmere/api
 */
struct Course {
    let title: String?
    let subjectCode: String?
    let courseNumber: String?
    let credits: String?
    let description: String?
    let abbr: String?
    
    var sections = [Section]()
    
    init(courseJSON: JSON) {
        title = courseJSON["title"].string as String?
        subjectCode = courseJSON["subjectCode"].string as String?
        courseNumber = courseJSON["courseNumber"].string as String?
        credits = courseJSON["credits"].string as String?
        description = courseJSON["description"].string as String?
        abbr = (subjectCode ?? "") + " " + (courseNumber ?? "0")
        
        // If sections exist, create array of sections
        if let sectionArray = courseJSON["sections"].array {
            for section in sectionArray {
                let courseSection = Section(sectionJSON: section)
                sections.append(courseSection)
            }
        }
    }
}