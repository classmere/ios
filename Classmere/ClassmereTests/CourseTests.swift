import XCTest
@testable import Classmere

class CourseTests: XCTestCase {

    let provider = DummyProvider()

    func testParseCourse() {
        let expectation = XCTestExpectation(description: "Parse sample course supplied from file by DummyProvider")
        provider.get(subjectCode: "CS", courseNumber: 161) { result in
            switch result {
            case .success(let course):
                XCTAssertEqual(course.title, "CS 161 INTRODUCTION TO COMPUTER SCIENCE I")
                XCTAssertEqual(course.subjectCode, "CS")
                XCTAssertEqual(course.courseNumber, 161)
                XCTAssertEqual(course.credits, "4")
                XCTAssertNotNil(course.description)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testPerformanceExample() {
        self.measure {
            for _ in 0...20 {
                _ = provider.get(subjectCode: "CS", courseNumber: 161) { $0 }
            }
        }
    }

}
