//
//  SearchViewModel.swift
//  classmereApp
//
//  Created by Nawwaf Almutairi on 10/28/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import Foundation
import Alamofire

/**
  Some presentation logic for the searching.
 */
class SearchViewModel {
    var courses = [Course]()
    var currentRequest: Request?

    /**
     Search for courses given user query using APIService.
     
     - Parameter query: User's search query.
     - Parameter completed: A callback that returns nothing.
     - Returns: Nothing
     */
    func fetchSearchCourses(query: String, completed: () -> Void) {
        if let currentRequest = currentRequest {
            currentRequest.cancel()
        }
        currentRequest = APIService.searchCourse(query) { coursesJSON in
            self.courses.removeAll(keepCapacity: true)
            for (_, courseJSON) in coursesJSON {
                let course = Course(courseJSON: courseJSON)
                self.courses.append(course)
                completed()
            }
        }
    }
}
