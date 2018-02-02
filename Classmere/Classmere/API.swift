import Foundation

enum API {
    case building(String)
    case course(String, Int)
    case searchBuilding(String)
    case searchCourse(String)
}

protocol Path {
    var baseURL: URL { get }
    var path: String { get }
}

extension API: Path {
    var baseURL: URL { return URL(string: "https://api.classmere.com")! }
    var path: String {
        switch self {
        case .building(let buildingName):
            return "/buildings/\(buildingName)"
        case .course(let subjectCode, let courseNumber):
            return "/courses/\(subjectCode.capitalized)/\(courseNumber)"
        case .searchBuilding(let searchString):
            return "/search/buildings/\(searchString)"
        case .searchCourse(let searchString):
            return "/search/courses/\(searchString)"
        }
    }
}

func url(_ path: Path) -> URL {
    return path.baseURL.appendingPathComponent(path.path)
}
