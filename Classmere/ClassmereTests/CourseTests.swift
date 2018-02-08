// swiftlint:disable force_try
import XCTest
@testable import Classmere

class CourseTests: XCTestCase {

    let decoder = JSONDecoder()
    var json: Data!

    override func setUp() {
        super.setUp()
        let jsonURL = URL(fileURLWithPath: Bundle.main.path(forResource: "course", ofType: "json")!)
        json = try! Data(contentsOf: jsonURL)
    }

    func testParseCourse() {
        let course = try! decoder.decode(Course.self, from: json)
        XCTAssertEqual(course.title, "CS 161 INTRODUCTION TO COMPUTER SCIENCE I")
        XCTAssertEqual(course.subjectCode, "CS")
        XCTAssertEqual(course.courseNumber, 161)
        XCTAssertEqual(course.credits, "4")
        XCTAssertNotNil(course.description)
    }

    func testPerformanceExample() {
        self.measure {
            for _ in 0...20 {
                _ = try! decoder.decode(Course.self, from: json)
            }
        }
    }

}
