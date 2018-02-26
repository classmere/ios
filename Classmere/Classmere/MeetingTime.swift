import Foundation

/**
 A model representation of a section's meetingTime at OSU.
 Reference Docs - https://github.com/classmere/api
 */

struct MeetingTime: Decodable {
    let startTime: Date?
    let endTime: Date?
    let days: String?
    let buildingCode: String?
    let roomNumber: Int?
}
