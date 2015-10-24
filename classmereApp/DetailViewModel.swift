//
//  DetailViewModel.swift
//  classmere
//
//  Created by Rutger Farry on 10/22/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    var course: Course
    var building: Building?
    
    init(course: Course) {
        self.course = course
    }
    
    func getBuildingLocationForSection(section: CourseSection, completed: () -> Void) {
        if let buildingCode = section.buildingCode {
            APIService.getLocationByAbbr(buildingCode) { json in
                self.building = Building(buildingJSON: json)
                completed()
            }
        }
    }
}