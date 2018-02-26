import Foundation

protocol Provider {
    typealias Completion<T> = (Result<T>) -> Void
    func get(buildingAbbr: String, completion: @escaping Completion<Building>)
    func get(subjectCode: String, courseNumber: Int, completion: @escaping Completion<Course>)
    func search(building: String, completion: @escaping Completion<[Building]>)
    func search(course: String, completion: @escaping Completion<[Course]>)
}

//extension Provider {
//
//    fileprivate func get<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping Completion<T>) {}
//
//    func get(buildingAbbr: String, completion: @escaping Completion<Building>) {
//        return get(url: API.building(buildingAbbr).path,
//                   responseType: Building.self,
//                   completion: completion)
//    }
//
//    func get(subjectCode: String, courseNumber: Int, completion: @escaping Completion<Course>) {
//        return get(url: API.course(subjectCode, courseNumber).path,
//                   responseType: Course.self,
//                   completion: completion)
//    }
//
//    func search(building: String, completion: @escaping Completion<[Building]>) {
//        return get(url: API.searchBuilding(building).path,
//                   responseType: Array<Building>.self,
//                   completion: completion)
//    }
//
//    func search(course: String, completion: @escaping Completion<[Course]>) {
//        return get(url: API.searchCourse(course).path,
//                   responseType: Array<Course>.self,
//                   completion: completion)
//    }
//
//}

