import XCTest
@testable import Classmere

class BuildingTests: XCTestCase {

    let provider = DummyProvider()

    func testParseBuilding() {
        let expectation = XCTestExpectation(description: "Parse sample building supplied from file by DummyProvider")
        provider.get(buildingAbbr: "KEC") { result in
            switch result {
            case .success(let building):
                XCTAssertEqual(building.abbr, "KEC")
                XCTAssertEqual(building.name, "Kelley Engineering Center")
                XCTAssertEqual(building.buildingNumber, 3)
                XCTAssertEqual(building.latitude, 44.567164)
                XCTAssertEqual(building.longitude, -123.278692)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testPerformanceExample() {
        self.measure {
            for _ in 0...5 {
                provider.get(buildingAbbr: "KEC") { _ in }
            }
        }
    }

}
