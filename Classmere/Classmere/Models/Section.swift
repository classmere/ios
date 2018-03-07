import Foundation

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
    let meetingTimes: [MeetingTime]?
    let startDate: String?
    let endDate: String?
    let campus: String?
    let type: String
    let status: String?
    let enrollmentCapacity: Int?
    let enrollmentCurrent: Int?
    let waitlistCapacity: Int?
    let waitlistCurrent: Int?
    let fees: String?
    let restrictions: String?
    let comments: String?
    let textbookUrl: String?
}
