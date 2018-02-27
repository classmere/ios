import XCTest
@testable import Classmere

class DataFormatterTests: XCTestCase {

    func testParseTermStandardInput() {
        XCTAssertEqual(DataFormatter.parseTerm("Sp18"), "Spring 2018")
        XCTAssertEqual(DataFormatter.parseTerm("Su18"), "Summer 2018")
        XCTAssertEqual(DataFormatter.parseTerm("F18"), "Fall 2018")
        XCTAssertEqual(DataFormatter.parseTerm("W18"), "Winter 2018")
    }

    func testParseTermNil() {
        XCTAssertEqual(DataFormatter.parseTerm(nil), "")
    }
}
