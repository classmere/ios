//
//  CourseSection.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/30/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CourseSection {
    let term: String?
    let session: String?
    let crn: Int?
    let meetingTimes: [JSON]
    
    // Within the array
    let buildingCode: String?
    let days: String?
    let startTime: String?
    let endTime: String?
    let roomNumber: String?
    
    // --
    let startDate: String?
    let endDate: String?
    let campus: String?
    let type: String?
    let status: String?
    let capacity: Int?
    let currentEnrollment: Int?
    let waitlistCurrent: Int?
    let fees: String?
    let restrictions: String?
    
    // Missing...
    let sectionNumber: Int?
    let instructor: String?
    let enrolled: Int?
    let comments: String?
    let waitlistCapacity: Int?

    init(sectionJSON: JSON) {
        term = sectionJSON["term"].string as String?
        startDate = sectionJSON["startDate"].string as String?
        endDate = sectionJSON["endDate"].string as String?
        crn = sectionJSON["crn"].intValue as Int?
        sectionNumber = sectionJSON["section"].intValue as Int?
        instructor = sectionJSON["instructor"].string as String?
        days = sectionJSON["days"].string as String?
        startTime = sectionJSON["startTime"].string as String?
        endTime = sectionJSON["endTime"].string as String?
        location = sectionJSON["location"].string as String?
        campus = sectionJSON["campus"].string as String?
        type = sectionJSON["type"].string as String?
        status = sectionJSON["status"].string as String?
        enrolled = sectionJSON["enrolled"].intValue as Int?
        fees = sectionJSON["fees"].string as String?
        restrictions = sectionJSON["restrictions"].string as String?
        comments = sectionJSON["comments"].string as String?
        waitlistCapacity = sectionJSON["waitlistCapacity"].intValue as Int?
        waitlistCurrent = sectionJSON["waitlistcurrent"].intValue as Int?
        currentEnrollment = sectionJSON["currentEnrollment"].intValue as Int?
        capacity = sectionJSON["capacity"].intValue as Int?
    }
}