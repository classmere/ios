import Foundation

class Store {
    fileprivate let externalFetcher: Provider
    fileprivate var _buildings: [Int: Building] = [:]
    fileprivate var _courses: [Int: Course] = [:]

    var currentCourse: Course?
    var currentSection: Section?

    fileprivate(set) var buildingSearchResults: [Building] = []
    fileprivate(set) var courseSearchResults: [Course] = []

    init(provider: Provider) {
        externalFetcher = provider
    }
}

extension Store: Provider {
    func get(buildingAbbr: String, completion: @escaping Completion<Building>) {
        if let building = _buildings[Building(abbr: buildingAbbr).hashValue] {
            completion(.success(building))
        } else {
            externalFetcher.get(buildingAbbr: buildingAbbr) { result in
                switch result {
                case .success(let building):
                    self._buildings[building.hashValue] = building
                    completion(.success(building))
                case .failure(let error): completion(.failure(error))
                }
            }
        }
    }

    func get(subjectCode: String, courseNumber: Int, completion: @escaping Completion<Course>) {
        if let course = _courses[Course(subjectCode: subjectCode, courseNumber: courseNumber).hashValue] {
            completion(.success(course))
        } else {
            externalFetcher.get(subjectCode: subjectCode, courseNumber: courseNumber) { result in
                switch result {
                case .success(let course):
                    self._courses[course.hashValue] = course
                    completion(.success(course))
                case .failure(let error): completion(.failure(error))
                }
            }
        }
    }

    func search(building: String, completion: @escaping Completion<[Building]>) {
        externalFetcher.search(building: building) { result in
            if case let .success(buildings) = result {
                self.buildingSearchResults = buildings
            } else {
                self.buildingSearchResults = []
            }
            completion(result)
        }
    }

    func search(course: String, completion: @escaping Completion<[Course]>) {
        externalFetcher.search(course: course) { result in
            if case let .success(courses) = result {
                self.courseSearchResults = courses
            } else {
                self.courseSearchResults  = []
            }
            completion(result)
        }
    }
}
