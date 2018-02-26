import Foundation

typealias Completion<T> = (Result<T>) -> Void

protocol Provider {
    func get<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping Completion<T>)
    func get(buildingAbbr: String, completion: @escaping Completion<Building>)
    func get(subjectCode: String, courseNumber: Int, completion: @escaping Completion<Course>)
    func search(building: String, completion: @escaping Completion<[Building]>)
    func search(course: String, completion: @escaping Completion<[Course]>)
}

/// Default implementations for convenience functions, only get(url: responseType: completion: ) needs to be implemented
extension Provider {

    func get(buildingAbbr: String, completion: @escaping Completion<Building>) {
        return get(url: API.building(buildingAbbr).path,
                   responseType: Building.self,
                   completion: completion)
    }

    func get(subjectCode: String, courseNumber: Int, completion: @escaping Completion<Course>) {
        return get(url: API.course(subjectCode, courseNumber).path,
                   responseType: Course.self,
                   completion: completion)
    }

    func search(building: String, completion: @escaping Completion<[Building]>) {
        return get(url: API.searchBuilding(building).path,
                   responseType: Array<Building>.self,
                   completion: completion)
    }

    func search(course: String, completion: @escaping Completion<[Course]>) {
        return get(url: API.searchCourse(course).path,
                   responseType: Array<Course>.self,
                   completion: completion)
    }

}
