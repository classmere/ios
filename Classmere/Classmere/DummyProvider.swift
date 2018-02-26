import Foundation

enum DummyProviderError: Error {
    case fileDoesNotExist
    case jsonParsing
}

struct DummyProvider {
    fileprivate let decoder = JSONDecoder()

    fileprivate func decode<T: Decodable>(_ type: T.Type, from: Data) -> Result<T> {
        do {
            let result = try self.decoder.decode(type, from: from)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }

    fileprivate func get<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping Completion<T>) {
        let fileString = url.relativeString
            .dropFirst()
            .replacingOccurrences(of: "/", with: "-")
        guard let filePath = Bundle.main.path(forResource: fileString, ofType: "json") else {
            return completion(.failure(DummyProviderError.fileDoesNotExist))
        }
        let fileURL = URL(fileURLWithPath: filePath)
        guard let json = try? Data(contentsOf: fileURL) else {
            return completion(.failure(DummyProviderError.jsonParsing))
        }

        completion(self.decode(responseType, from: json))
    }

}

extension DummyProvider: Provider {

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
