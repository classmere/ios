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
    
    static let baseURL = "http://classmere.herokuapp.com"
    
    static func getAllCourses(completion: (JSON) -> Void) {
        SwiftSpinner.show("Fetching Data...")
        Alamofire.request(.GET, "\(baseURL)/courses/")
            .responseJSON {(request, response, result) in
                switch result {
                case .Success(let data):
                    completion(JSON(data))
                    SwiftSpinner.hide()
                    
                case .Failure(_, let error):
                    print("Request failed with error: \(error)")
                    SwiftSpinner.hide()
                }
        }
    }
    
    static func getCourseByAbbr(abbr: String, completion: (JSON) -> Void) {
        SwiftSpinner.show("Fetching Data...")
        let encodedAbbr: String = "\(abbr)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        Alamofire.request(.GET, "\(baseURL)/courses/\(encodedAbbr)")
            .responseJSON {(request, response, result) in
                switch result {
                case .Success(let data):
                    completion(JSON(data))
                    SwiftSpinner.hide()
                    
                case .Failure( _, let error):
                    print("Request failed with error: \(error)")
                    SwiftSpinner.hide()
                }
        }
    }
    
    static func searchCourse(searchQuery: String, completion: (JSON) -> Void) {
        SwiftSpinner.show("Fetching Data...")
        let encodedSearchQuery: String = "\(searchQuery)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        Alamofire.request(.GET, "\(baseURL)/search/courses/\(encodedSearchQuery)")
            .responseJSON {(request, response, result) in
                switch result {
                case .Success(let data):
                    completion(JSON(data))
                    SwiftSpinner.hide()
                    
                case .Failure(_, let error):
                    print("Request failed with error: \(error)")
                    SwiftSpinner.hide()
                }
        }
    }
}