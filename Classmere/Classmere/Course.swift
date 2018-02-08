import Foundation
import SwiftyJSON

/**
 A model representation of a course at OSU.
 Reference Docs - https://github.com/classmere/api
 */

struct PlainCourse: Decodable {
    let subjectCode: String
    let courseNumber: Int
    let title: String?
    let credits: String?
    let description: String?
    let abbr: String?
}
struct Course: Decodable {
    let subjectCode: String
    let courseNumber: Int
    let title: String?
    let credits: String?
    let description: String?
    var sections: [Section]

    var abbr: String {
        return subjectCode + " " + String(courseNumber)
    }

    init(courseJSON: JSON) {
        title = courseJSON["title"].string
        subjectCode = courseJSON["subjectCode"].string!
        courseNumber = courseJSON["courseNumber"].int!
        credits = courseJSON["credits"].string
        description = courseJSON["description"].string
        sections = []

        // If sections exist, create array of sections
        if let sectionArray = courseJSON["sections"].array {
            for section in sectionArray {
                let courseSection = Section(sectionJSON: section)
                sections.append(courseSection)
            }
        }
    }

    init(subjectCode: String, courseNumber: Int) {
        self.subjectCode = subjectCode
        self.courseNumber = courseNumber
        self.title = nil
        self.credits = nil
        self.description = nil
        self.sections = []
    }
}

extension Course: Hashable {
    var hashValue: Int {
        return subjectCode.hashValue ^ courseNumber.hashValue &* 16777619
    }

    static func == (lhs: Course, rhs: Course) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
