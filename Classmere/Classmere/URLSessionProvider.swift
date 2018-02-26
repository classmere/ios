import Foundation

enum URLSessionProviderError: Error {
    case noData
}

struct URLSessionProvider {
    fileprivate let session = URLSession.shared
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
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, _, error in
            if let error = error { completion(.failure(error)) }
            guard let data = data else { return completion(.failure(URLSessionProviderError.noData)) }
            completion(self.decode(responseType, from: data))
        }.resume()
    }

}

extension URLSessionProvider: Provider {

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
