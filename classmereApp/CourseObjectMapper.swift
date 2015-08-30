//
//  CourseObjectMapper.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/29/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CourseObjectMapper {
    
    // take courseJSON and parse it in to dictionary
    // feed that into dictionary into course object
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> ()
    /*
    func mapCourseDictionary(/*completion: JSONDictionaryCompletion*/) -> Course {
        let test: Course
        APIService.getCourseByAbbr("CS%20161") { (data) -> Void in
            let test = Course(courseJSON: data)
        }
        return test
    }
    */
}

/*
APIService.getCourseByAbbr("CS%20161") { (data) -> Void in
    if let theTitle = data["title"].string {
        println(theTitle)
        self.titleLabel?.text = theTitle
    }
}
*/