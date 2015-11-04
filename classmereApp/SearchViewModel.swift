//
//  SearchViewModel.swift
//  classmereApp
//
//  Created by Nawwaf Almutairi on 10/28/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import Foundation

class SearchViewModel {
    var courses = [Course]()

    func fetchSearchCourses(query: String, completed: () -> Void) {
        APIService.searchCourse(query) { coursesJSON in
            for (_, courseJSON) in coursesJSON {
                let course = Course(courseJSON: courseJSON)
                self.courses.append(course)
                completed()
            }
        }
    }
}

