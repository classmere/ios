import XCTest
@testable import Classmere

class APITests: XCTestCase {

    func testUrl() {
        XCTAssertEqual(API.course("CS", 161).path,
                       URL(string: "https://api.classmere.com/courses/CS/161"))
        XCTAssertEqual(API.building("KeC").path,
                       URL(string: "https://api.classmere.com/buildings/KEC"))
        XCTAssertEqual(API.searchBuilding("austin entrepenuership").path,
                           URL(string: "https://api.classmere.com/search/buildings/austin%20entrepenuership"))
        XCTAssertEqual(API.searchCourse("film 220").path,
                       URL(string: "https://api.classmere.com/search/courses/film%20220"))
    }

}
