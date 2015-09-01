//
//  CourseSection.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/30/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct CourseSection {
    let term: String?
    let startDate: String?
    let endDate: String?
    let session: String?
    let crn: Int?
    let sectionNumber: Int?
    let instructor: String?
    let days: String?
    let startTime: String?
    let endTime: String?
    let location: String?
    let campus: String?
    let type: String?
    let status: String?
    let enrolled: Int?
    let fees: String?
    let restrictions: String?
    let comments: String?
    let waitlistCapacity: Int?
    let waitlistCurrent: Int?
    let currentEnrollment: Int?
    
    // TODO: Might wanna make this prettier...
    init(sectionJSON: JSON) {
        term = sectionJSON["term"].string as String?
        startDate = sectionJSON["startDate"].string as String?
        endDate = sectionJSON["endDate"].string as String?
        session = sectionJSON["session"].string as String?
        crn = sectionJSON["crn"].intValue as Int?
        sectionNumber = sectionJSON["sectionNumber"].intValue as Int?
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
    }
}