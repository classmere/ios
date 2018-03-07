import Foundation

enum URLSessionProviderError: Error {
    case noData
}

struct URLSessionProvider: Provider {
    fileprivate let session = URLSession.shared
    fileprivate let decoder = JSONDecoder()

    init() {
        decoder.dateDecodingStrategy = .iso8601
    }

    private func decode<T: Decodable>(_ type: T.Type, from: Data) -> Result<T> {
        do {
            let result = try self.decoder.decode(type, from: from)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }

    internal func get<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping Completion<T>) {
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, _, error in
            if let error = error { completion(.failure(error)) }
            guard let data = data else { return completion(.failure(URLSessionProviderError.noData)) }
            completion(self.decode(responseType, from: data))
        }.resume()
    }

}
