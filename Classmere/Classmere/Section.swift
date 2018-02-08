import Foundation
import SwiftyJSON

/**
 A model representation of a course's section at OSU.
 Reference Docs - https://github.com/classmere/api
 */
struct Section: Decodable {
    let term: String?
    let session: String?
    let crn: Int?
    let credits: Int?
    let instructor: String?

    // Meeting times array keys
//    let startTime: Date?
//    let endTime: Date?
//    let days: String?
//    let buildingCode: String?
//    let roomNumber: String?
//
    let startDate: String?
    let endDate: String?
    let campus: String?
    let type: String?
    let status: String?
    let enrollmentCapacity: Int?
    let enrollmentCurrent: Int?
    let waitlistCapacity: Int?
    let waitlistCurrent: Int?
//    let fees: String?
//    let restrictions: String?
//    let comments: String?
//    let textbookUrl: String?
//
//    var building: Building?

    init(sectionJSON: JSON) {
        term = sectionJSON["term"].string as String?
        session = sectionJSON["session"].string as String?
        crn = sectionJSON["crn"].int as Int?
        credits = sectionJSON["credits"].int as Int?
        instructor = sectionJSON["instructor"].string as String?

//        if let meetingTimes = sectionJSON["meetingTimes"].array {
//            startTime = DataFormatter.dateFromISO8601String(meetingTimes[0]["startTime"].string)
//            endTime = DataFormatter.dateFromISO8601String(meetingTimes[0]["endTime"].string)
//            days = meetingTimes[0]["days"].string
//            buildingCode = meetingTimes[0]["buildingCode"].string
//            roomNumber = meetingTimes[0]["roomNumber"].string
//        } else {
//            startTime = nil
//            endTime = nil
//            days = nil
//            buildingCode = nil
//            roomNumber = nil
//        }
//
        startDate = sectionJSON["startDate"].string
        endDate = sectionJSON["endDate"].string
        campus = sectionJSON["campus"].string
        type = sectionJSON["type"].string
        status = sectionJSON["status"].string
        enrollmentCapacity = sectionJSON["enrollmentCapacity"].int
        enrollmentCurrent = sectionJSON["enrollmentCurrent"].int
        waitlistCapacity = sectionJSON["waitlistCapacity"].int
        waitlistCurrent = sectionJSON["waitlistCurrent"].int
//        fees = sectionJSON["fees"].string as String?
//        restrictions = sectionJSON["restrictions"].string as String?
//        comments = sectionJSON["comments"].string as String?
//        textbookUrl = sectionJSON["textbookUrl"].string as String?
    }
}
