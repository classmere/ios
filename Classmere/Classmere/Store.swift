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
    func get(buildingAbbr: String, completion: @escaping Completion<Building>) {
        if let building = buildings[Building(abbr: buildingAbbr).hashValue] {
            completion(.success(building))
        } else {
            externalFetcher.get(buildingAbbr: buildingAbbr) { result in
                switch result {
                case .success(let building):
                    self.buildings[building.hashValue] = building
                    completion(.success(building))
                case .failure(let error): completion(.failure(error))
                }
            }
        }
    }

    func get(subjectCode: String, courseNumber: Int, completion: @escaping Completion<Course>) {
        if let course = courses[Course(subjectCode: subjectCode, courseNumber: courseNumber).hashValue] {
            completion(.success(course))
        } else {
            externalFetcher.get(subjectCode: subjectCode, courseNumber: courseNumber) { result in
                switch result {
                case .success(let course):
                    self.courses[course.hashValue] = course
                    completion(.success(course))
                case .failure(let error): completion(.failure(error))
                }
            }
        }
    }

    func search(building: String, completion: @escaping Completion<[Building]>) {
        externalFetcher.search(building: building, completion: completion)
    }

    func search(course: String, completion: @escaping Completion<[Course]>) {
        externalFetcher.search(course: course, completion: completion)
    }
}
