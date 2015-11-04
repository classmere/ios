//
//  TodayViewModel.swift
//  classmere
//
//  Created by Rutger Farry on 10/21/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//

import Foundation
import SwiftyJSON

class TodayViewModel {
    var courses = [Course]()
        
    func fetchCourseData(requestedCourses: [(String, Int)], completed: () -> Void) {
        var coursesFetched = 0
        for requestedCourse in requestedCourses {
            APIService.getCourseBySubjectCode(requestedCourse.0, courseNumber: requestedCourse.1) { courseJSON in
                let course: Course = Course(courseJSON: courseJSON)
                self.courses.append(course)
                coursesFetched++
                if coursesFetched == requestedCourses.count {
                    self.courses.sortInPlace({
                        if let time1 = $0.courseSections[0].startTime, time2 = $1.courseSections[0].startTime {
                            return time1.earlierDate(time2) == time1 ? true : false
                        }
                        return true
                    })
                    completed()
                }
            }
        }
    }
    
    func fetchBuildingDataForSections(sections: [CourseSection], completed: () -> Void) {
        var buildingsFetched = 0
        for (index, section) in sections.enumerate() {
            if let buildingCode = section.buildingCode {
                APIService.getLocationByAbbr(buildingCode) { buildingJSON in
                    let building = Building(buildingJSON: buildingJSON)
                    self.courses[index].courseSections[0].building = building
                    buildingsFetched++
                    completed()
                }
            }
        }
    }
}