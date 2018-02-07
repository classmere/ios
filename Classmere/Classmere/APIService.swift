import Foundation
import Alamofire
import SwiftyJSON

/**
 A representation of Classmere's API service.
 Reference Docs - https://github.com/classmere/api
 */
struct APIService {

    static let baseURL = "https://api.classmere.com"

    // MARK: Course Requests

    /**
     Fetches all courses at OSU in a single request.
     
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
    static func getAllCourses(_ completion: @escaping (JSON) -> Void) -> Request {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        return Alamofire.request("\(baseURL)/courses/")
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    completion(JSON(data))
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }

        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    /**
     Fetches a specific course at OSU by its subject code.
     
     - Parameter subjectCode: The first part of the course abbreviation.
     - Parameter courseNumber: The number ID of the particular course.
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
    static func getCourseBySubjectCode(_ subjectCode: String,
                                       courseNumber: Int,
                                       completion: @escaping (JSON) -> Void) -> Request {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        return Alamofire.request("\(baseURL)/courses/\(subjectCode)/\(courseNumber)/")
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    completion(JSON(data))
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }

        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    /**
     Fetches a specific course at OSU by a user query.
     
     - Parameter query: The user inputted query.
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
    static func searchCourse(_ query: String, completion: @escaping (JSON) -> Void) -> Request {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let allowedCharacters = CharacterSet.urlQueryAllowed
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
        return Alamofire.request("\(baseURL)/search/courses/\(encodedQuery)/")
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    if response.response?.statusCode == 200 {
                        completion(JSON(data))
                    } else {
                        print("Course not found: \(query)")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completion(nil)
                }

        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    // MARK: Building Requests

    /**
     Fetches a specific location at OSU by course's abbreviation.
     
     - Parameter abbr: The course's abbreviation.
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
    static func getBuildingByAbbr(_ abbr: String, completion: @escaping (JSON) -> Void) -> Request {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        return Alamofire.request("\(baseURL)/buildings/\(abbr)")
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    completion(JSON(data))
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }

        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    /**
     Fetches a specific building at OSU by a user query.
     
     - Parameter query: The user inputted query.
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
    static func searchBuilding(_ query: String, completion: @escaping (JSON) -> Void) -> Request {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let allowedCharacters = CharacterSet.urlQueryAllowed
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
        return Alamofire.request("\(baseURL)/search/buildings/\(encodedQuery)/")
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    if response.response?.statusCode == 200 {
                        completion(JSON(data))
                    } else {
                        print("Building not found: \(query)")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completion(nil)
                }

        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
