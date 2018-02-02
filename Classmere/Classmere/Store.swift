import Foundation

class Store {
    fileprivate var buildings: [Int: Building]
    fileprivate var courses: [Int: Course]
    fileprivate let externalFetcher: Provider

    init(provider: Provider) {
        buildings = [:]
        courses = [:]
        externalFetcher = provider
    }
}

extension Store: Provider {
    func get(buildingAbbr: String, callback: @escaping Callback<Building>) throws {
        if let building = buildings[Building(abbr: buildingAbbr).hashValue] {
            callback(building)
        } else {
            try externalFetcher.get(buildingAbbr: buildingAbbr) { building in
                self.buildings[building.hashValue] = building
                callback(building)
            }
        }
    }

    func get(subjectCode: String, courseNumber: Int, callback: @escaping Callback<Course>) throws {
        if let course = courses[Course(subjectCode: subjectCode, courseNumber: courseNumber).hashValue] {
            callback(course)
        } else {
            try externalFetcher.get(subjectCode: subjectCode, courseNumber: courseNumber) { course in
                self.courses[course.hashValue] = course
                callback(course)
            }
        }
    }

    func search(building: String, callback: @escaping Callback<Building>) throws {
        try externalFetcher.search(building: building, callback: callback)
    }

    func search(course: String, callback: @escaping Callback<Course>) throws {
        try externalFetcher.search(course: course, callback: callback)
    }
}

protocol Provider {
    typealias Callback<T> = (T) -> Void
    func get(buildingAbbr: String, callback: @escaping Callback<Building>) throws
    func get(subjectCode: String, courseNumber: Int, callback: @escaping Callback<Course>) throws
    func search(building: String, callback: @escaping Callback<Building>) throws
    func search(course: String, callback: @escaping Callback<Course>) throws
}
