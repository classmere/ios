//
//  APIService.swift
//  Classmere
//
//  Created by Brandon Lee on 8/8/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/**
 A representation of Classmere's API service.
 Reference Docs - https://github.com/classmere/api
 */
struct APIService {
    
    static let baseURL = "http://138.68.48.26:5000"
    
    // MARK: Course Requests
    
    /**
     Fetches all courses at OSU in a single request.
     
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
    static func getAllCourses(completion: (JSON) -> Void) -> Request {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        return Alamofire.request(.GET, "\(baseURL)/courses/")
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    completion(JSON(data))
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
                
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    /**
     Fetches a specific course at OSU by its subject code.
     
     - Parameter subjectCode: The first part of the course abbreviation.
     - Parameter courseNumber: The number ID of the particular course.
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
    static func getCourseBySubjectCode(subjectCode: String, courseNumber: Int, completion: (JSON) -> Void) -> Request {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        return Alamofire.request(.GET, "\(baseURL)/courses/\(subjectCode)/\(courseNumber)/")
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    completion(JSON(data))
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
                
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    /**
     Fetches a specific course at OSU by a user query.
     
     - Parameter query: The user inputted query.
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
    static func searchCourse(query: String, completion: (JSON) -> Void) -> Request {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet()
        let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)!
        return Alamofire.request(.GET, "\(baseURL)/search/courses/\(encodedQuery)/")
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    if response.response?.statusCode == 200 {
                        completion(JSON(data))
                    } else {
                        print("Course not found: \(query)")
                        completion(nil)
                    }
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    completion(nil)
                }
                
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    // MARK: Building Requests
    
    /**
     Fetches a specific location at OSU by course's abbreviation.
     
     - Parameter abbr: The course's abbreviation.
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
    static func getBuildingByAbbr(abbr: String, completion: (JSON) -> Void) -> Request {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        return Alamofire.request(.GET, "\(baseURL)/buildings/\(abbr)")
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    completion(JSON(data))
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
                
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    /**
     Fetches a specific building at OSU by a user query.
     
     - Parameter query: The user inputted query.
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
    static func searchBuilding(query: String, completion: (JSON) -> Void) -> Request {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet()
        let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)!
        return Alamofire.request(.GET, "\(baseURL)/search/buildings/\(encodedQuery)/")
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    if response.response?.statusCode == 200 {
                        completion(JSON(data))
                    } else {
                        print("Building not found: \(query)")
                        completion(nil)
                    }
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    completion(nil)
                }
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}