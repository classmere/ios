//
//  Section.swift
//  Classmere
//
//  Created by Brandon Lee on 8/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 A model representation of a course's section at OSU.
 Reference Docs - https://github.com/classmere/api
 */
struct Section {
    let term: String?
    let session: String?
    let crn: String?
    let credits: String?
    let instructor: String?
    
    // Meeting times array keys
    let startTime: NSDate?
    let endTime: NSDate?
    let days: String?
    let buildingCode: String?
    let roomNumber: String?
    
    let startDate: String?
    let endDate: String?
    let campus: String?
    let type: String?
    let status: String?
    let enrollmentCapacity: String?
    let enrollmentCurrent: String?
    let waitlistCapacity: String?
    let waitlistCurrent: String?
    let fees: String?
    let restrictions: String?
    let comments: String?
    let textbookUrl: String?
    
    var building: Building?
    
    init(sectionJSON: JSON) {
        term = sectionJSON["term"].string as String?
        session = sectionJSON["session"].string as String?
        crn = sectionJSON["crn"].string as String?
        credits = sectionJSON["credits"].string as String?
        instructor = sectionJSON["instructor"].string as String?
        
        if let meetingTimes = sectionJSON["meetingTimes"].array {
            startTime = Section.dateFromISO8601String(meetingTimes[0]["startTime"].string)
            endTime = Section.dateFromISO8601String(meetingTimes[0]["endTime"].string)
            days = meetingTimes[0]["days"].string
            buildingCode = meetingTimes[0]["buildingCode"].string
            roomNumber = meetingTimes[0]["roomNumber"].string
        } else {
            startTime = nil
            endTime = nil
            days = nil
            buildingCode = nil
            roomNumber = nil
        }
        
        startDate = sectionJSON["startDate"].string as String?
        endDate = sectionJSON["endDate"].string as String?
        campus = sectionJSON["campus"].string as String?
        type = sectionJSON["type"].string as String?
        status = sectionJSON["status"].string as String?
        enrollmentCapacity = sectionJSON["enrollmentCapacity"].string as String?
        enrollmentCurrent = sectionJSON["enrollmentCurrent"].string as String?
        waitlistCapacity = sectionJSON["waitlistCapacity"].string as String?
        waitlistCurrent = sectionJSON["waitlistCurrent"].string as String?
        fees = sectionJSON["fees"].string as String?
        restrictions = sectionJSON["restrictions"].string as String?
        comments = sectionJSON["comments"].string as String?
        textbookUrl = sectionJSON["textbookUrl"].string as String?
    }
    
    /**
     Converts string returned in JSON to a NSDate.
     Offsets time by -7 hours since API returns GMT timezone
     
     - Parameter iso8601String: A string optional with valid date.
     - Returns: A converted NSDate Optional
     
     */
    static func dateFromISO8601String(iso8601String: String?) -> NSDate? {
        if let iso8601String = iso8601String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ssZ"
            let date = dateFormatter.dateFromString(iso8601String)
            let subtractSevenHours = NSTimeInterval(60*60*7)
            let offsetDate = date?.dateByAddingTimeInterval(subtractSevenHours)
            return offsetDate
        }
        return nil
    }
}