import Foundation

enum DummyProviderError: Error {
    case fileDoesNotExist
    case jsonParsing
}

struct DummyProvider: Provider {
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
        let fileString = url.absoluteString
            .replacingOccurrences(of: API.baseURL.absoluteString, with: "")
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
