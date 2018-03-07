import Foundation

/**
 A model representation of a course at OSU.
 Reference Docs - https://github.com/classmere/api
 */

struct Course: Decodable {
    let subjectCode: String
    let courseNumber: Int
    let title: String?
    let credits: String?
    let description: String?
    let sections: [Section]

    var abbr: String {
        return subjectCode + " " + String(courseNumber)
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
