//
//  DetailViewModel.swift
//  classmere
//
//  Created by Rutger Farry on 10/22/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//

import Foundation

/**
 Some presentation logic for the today view's detail view.
 */
class DetailViewModel {
    
    var course: Course
    var courseSection: CourseSection?

    init(course: Course, courseSection: CourseSection) {
        self.course = course
        self.courseSection = courseSection
    }
    
    // FIXME: The following method is defined twice (TodayTableViewModel & DetailView Model) need to restructure!
    
    /**
     Calls APIService to get building data for specified sections.
     
     - Parameter sections: The sections to get building data for.
     - Parameter completed: A callback that returns nothing.
     - Returns: Nothing
     */
    func fetchBuildingDataForSections(sections: [CourseSection], completed: () -> Void) {
        var buildingsFetched = 0
        for section in sections {
            if let buildingCode = section.buildingCode {
                APIService.getLocationByAbbr(buildingCode) { buildingJSON in
                    let building = Building(buildingJSON: buildingJSON)
                    self.course.courseSections[0].building = building
                    buildingsFetched += 1
                    completed()
                }
            }
        }
    }
}
