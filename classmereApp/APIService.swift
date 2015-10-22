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
import SwiftSpinner

struct APIService {
    
    static let baseURL = "http://api.classmere.com"
    
    static func getAllCourses(completion: (JSON) -> Void) {
        SwiftSpinner.show("Fetching Data...")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.GET, "\(baseURL)/courses/")
            .responseJSON {(request, response, result) in
                switch result {
                case .Success(let data):
                    completion(JSON(data))
                    SwiftSpinner.hide()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false

                case .Failure(_, let error):
                    print("Request failed with error: \(error)")
                    SwiftSpinner.hide()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
        }
    }
    
    static func getCourseByAbbr(abbr: String, completion: (JSON) -> Void) {
        SwiftSpinner.show("Fetching Data...")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let encodedAbbr: String = abbr.stringByReplacingOccurrencesOfString(" ", withString: "/")
        
        Alamofire.request(.GET, "\(baseURL)/courses/\(encodedAbbr)")
            .responseJSON {(request, response, result) in
                switch result {
                case .Success(let data):
                    completion(JSON(data))
                    SwiftSpinner.hide()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                case .Failure( _, let error):
                    print("Request failed with error: \(error)")
                    SwiftSpinner.hide()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
        }
    }
    
    static func getLocationByAbbr(abbr: String, completion: (JSON) -> Void) {
        SwiftSpinner.show("Fetching Data...")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.GET, "\(baseURL)/buildings/\(abbr)")
            .responseJSON {(request, response, result) in
                switch result {
                case .Success(let data):
                    completion(JSON(data))
                    SwiftSpinner.hide()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                case .Failure(_, let error):
                    print("Request failed with error: \(error)")
                    SwiftSpinner.hide()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
        }
    }
    
    static func searchCourse(searchQuery: String, completion: (JSON) -> Void) {
        SwiftSpinner.show("Fetching Data...")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let encodedSearchQuery: String = "\(searchQuery)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        Alamofire.request(.GET, "\(baseURL)/search/courses/\(encodedSearchQuery)")
            .responseJSON {(request, response, result) in
                switch result {
                case .Success(let data):
                    completion(JSON(data))
                    SwiftSpinner.hide()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                case .Failure(_, let error):
                    print("Request failed with error: \(error)")
                    SwiftSpinner.hide()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
        }
    }
}