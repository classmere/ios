import Foundation

protocol Provider {
    typealias Completion<T> = (Result<T>) -> Void
    func get(buildingAbbr: String, completion: @escaping Completion<Building>)
    func get(subjectCode: String, courseNumber: Int, completion: @escaping Completion<Course>)
    func search(building: String, completion: @escaping Completion<[Building]>)
    func search(course: String, completion: @escaping Completion<[Course]>)
}
