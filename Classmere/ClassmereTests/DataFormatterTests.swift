import XCTest
@testable import Classmere

class UtilitiesTests: XCTestCase {

    func testParseTermStandardInput() {
        XCTAssertEqual(Utilities.parseTerm("Sp18"), "Spring 2018")
        XCTAssertEqual(Utilities.parseTerm("Su18"), "Summer 2018")
        XCTAssertEqual(Utilities.parseTerm("F18"), "Fall 2018")
        XCTAssertEqual(Utilities.parseTerm("W18"), "Winter 2018")
    }

    func testParseTermNil() {
        XCTAssertEqual(Utilities.parseTerm(nil), "")
    }

    func testSortTerms() {
        let term1 = "W18"
        let term2 = "Su18"

        XCTAssertEqual(term1[..<term1.index(term1.endIndex, offsetBy: -2)], "W")
        XCTAssertEqual(term2[..<term2.index(term2.endIndex, offsetBy: -2)], "Su")
        XCTAssertEqual(term1[term1.index(term1.endIndex, offsetBy: -2)...], "18")
        XCTAssertEqual(term2[term2.index(term2.endIndex, offsetBy: -2)...], "18")
    }
}
