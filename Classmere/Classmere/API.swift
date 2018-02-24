import Foundation

enum API {
    case building(String)
    case course(String, Int)
    case searchBuilding(String)
    case searchCourse(String)
}

protocol Path {
    var baseURL: URL { get }
    var path: URL { get }
}

extension API: Path {
    var baseURL: URL { return URL(string: "https://api.classmere.com")! }
    var path: URL {
        switch self {
        case .building(let buildingName):
            return url("/buildings/\(buildingName.uppercased())")
        case .course(let subjectCode, let courseNumber):
            return url("/courses/\(subjectCode.uppercased())/\(courseNumber)")
        case .searchBuilding(let searchString):
            return url("/search/buildings/\(searchString)")
        case .searchCourse(let searchString):
            return url("/search/courses/\(searchString)")
        }
    }

    private func url(_ path: String) -> URL {
        return baseURL.appendingPathComponent(path, isDirectory: false)
    }
}
