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
    
    static let baseURL = "http://api.classmere.com"
    
    static func getAllCourses(completion: (JSON) -> Void) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.GET, "\(baseURL)/courses/")
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    completion(JSON(data))
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
        }
    }
    
    static func getCourseBySubjectCode(subjectCode: String, courseNumber: Int, completion: (JSON) -> Void) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.GET, "\(baseURL)/courses/\(subjectCode)/\(courseNumber)")
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    completion(JSON(data))
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
        }
    }
    
    static func getLocationByAbbr(abbr: String, completion: (JSON) -> Void) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.GET, "\(baseURL)/buildings/\(abbr)")
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    completion(JSON(data))
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
        }
    }
    
    static func searchCourse(searchQuery: String, completion: (JSON) -> Void) -> Request {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let encodedSearchQuery = "\(searchQuery)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        return Alamofire.request(.GET, "\(baseURL)/search/courses/\(encodedSearchQuery)")
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    if response.response?.statusCode !== 200 {
                        print("Course not found: \(searchQuery)")
                        completion(nil)
                    } else {
                        completion(JSON(data))
                    }
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    completion(nil)
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}
