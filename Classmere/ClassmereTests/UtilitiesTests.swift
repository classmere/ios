// swiftlint:disable force_try

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

    func testSortTermsInOrder() {
        let terms = ["F18", "W19", "Sp19", "Su19"]
        let sorted = try! terms.sorted(by: Utilities.sortTerms)
        XCTAssertEqual(sorted, terms)
    }

    func testSortTermsBAC() {
        let terms = ["W18", "F17", "Su18"]
        let sorted = try! terms.sorted(by: Utilities.sortTerms)
        XCTAssertEqual(sorted, ["F17", "W18", "Su18"])
    }

    func testSortTermsACB() {
        let terms = ["F17", "Su18", "W18"]
        let sorted = try! terms.sorted(by: Utilities.sortTerms)
        XCTAssertEqual(sorted, ["F17", "W18", "Su18"])
    }

    func testSortTermsCAB() {
        let terms = ["F17", "W17", "Su17"]
        let sorted = try! terms.sorted(by: Utilities.sortTerms)
        XCTAssertEqual(sorted, ["W17", "Su17", "F17"])
    }

    func testSortTermsCBA() {
        let terms = ["F06", "F04", "F02"]
        let sorted = try! terms.sorted(by: Utilities.sortTerms)
        XCTAssertEqual(sorted, ["F02", "F04", "F06"])
    }

    func testSortTermsNoInput() {
        let sorted = try! [].sorted(by: Utilities.sortTerms)
        XCTAssertEqual(sorted, [])
    }
}
