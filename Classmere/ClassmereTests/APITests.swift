import XCTest
@testable import Classmere

class APITests: XCTestCase {
    
    func testUrl() {
        XCTAssertEqual(url(API.course("CS", 161)),
                       URL(string: "https://api.classmere.com/courses/Cs/161"))
        XCTAssertEqual(url(API.building("KEC")),
                       URL(string: "https://api.classmere.com/buildings/KEC"))
        XCTAssertEqual(url(API.searchBuilding("austin entrepenuership")),
                           URL(string: "https://api.classmere.com/search/buildings/austin%20entrepenuership"))
        XCTAssertEqual(url(API.searchCourse("film 220")),
                       URL(string: "https://api.classmere.com/search/courses/film%20220"))
    }
    
}
