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
    
    static func getAllCourses(callback:(JSON) -> Void) {
        Alamofire.request(.GET, "\(baseURL)/courses/")
            .responseJSON {(request, response, JSON, error) in
                if error == nil {
                    println(JSON)
                } else {
                    println(error)
                }
        }
    }
    
    static func getCourseByAbbr(abbr: String/*, callback:(JSON) -> Void*/) {
        Alamofire.request(.GET, "\(baseURL)/courses/\(abbr)")
            .responseJSON {(request, response, JSON, error) in
                if error == nil {
                    print(JSON)
                } else {
                    println(error)
                }
        }
    }
    
    static func derp() {
        println("Derp")
    }
    
}