// swiftlint:disable force_try

import XCTest
@testable import Classmere

class BuildingTests: XCTestCase {

    let decoder = JSONDecoder()
    var json: Data!

    override func setUp() {
        super.setUp()
        let jsonURL = URL(fileURLWithPath: Bundle.main.path(forResource: "building", ofType: "json")!)
        json = try! Data(contentsOf: jsonURL)
    }

    func testParseBuilding() {
        let building = try! decoder.decode(Building.self, from: json)
        XCTAssertEqual(building.abbr, "KEC")
        XCTAssertEqual(building.name, "Kelley Engineering Center")
        XCTAssertEqual(building.buildingNumber, 3)
        XCTAssertEqual(building.latitude, 44.567164)
        XCTAssertEqual(building.longitude, -123.278692)
    }

    func testPerformanceExample() {
        self.measure {
            for _ in 0...20 {
                _ = try! decoder.decode(Building.self, from: json)
            }
        }
    }

}
