//
//  APIService.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/25/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct APIService {
    
    static let baseURL = "http://classmere.herokuapp.com"
    
    static func getAllCourses(completion: (JSON) -> Void) {
        Alamofire.request(.GET, "\(baseURL)/courses/")
            .responseJSON {(request, response, data, error) in
                if error == nil {
                    var theData = JSON(data!)
                    completion(theData)
                } else {
                    println(error)
                }
        }
    }
    
    static func getCourseByAbbr(abbr: String, completion: (JSON) -> Void) {
        
        let encodedAbbr: String = "\(abbr)".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        Alamofire.request(.GET, "\(baseURL)/courses/\(encodedAbbr)")
            .responseJSON {(request, response, data, error) in
                if error == nil {
                    var theData = JSON(data!)
                    completion(theData)
                } else {
                    println(error)
                }
        }
    }
    
    static func searchCourse(searchQuery: String, completion: (JSON) -> Void) {
        
        let encodedSearchQuery: String = "\(searchQuery)".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        Alamofire.request(.GET, "\(baseURL)/search/courses/\(encodedSearchQuery)")
            .responseJSON {(request, response, data, error) in
                if error == nil {
                    var theData = JSON(data!)
                    completion(theData)
                } else {
                    println(error)
                }
        }
    }
}