import XCTest
@testable import Classmere

class URLSessionProviderTests: XCTestCase {

    let provider = URLSessionProvider()

    func testGetBuildingKelleyEngineering() {
        let expectation = XCTestExpectation(description: "GET Kelly Engineering Center from Classmere API")
        provider.get(buildingAbbr: "KEC") { result in
            switch result {
            case .success(let building):
                XCTAssertEqual(building.name, "Kelley Engineering Center")
                XCTAssertEqual(building.address, "110 SW Park Terrace")
                expectation.fulfill()
            case .failure:
                XCTFail("Failed to retrieve building from Classmere API. Check network connection")
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testGetBuildingMemorialUnion() {
        let expectation = XCTestExpectation(description: "GET Memorial Union from Classmere API")
        provider.get(buildingAbbr: "MU") { result in
            switch result {
            case .success(let building):
                XCTAssertTrue(building.name!.contains("Memorial Union"))
                XCTAssertEqual(building.address, "2501 SW Jefferson Way")
                expectation.fulfill()
            case .failure:
                XCTFail("Failed to retrieve building from Classmere API. Check network connection")
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testGetCoursePhysics201() {
        let expectation = XCTestExpectation(description: "GET Physics 201 from Classmere API")
        provider.get(subjectCode: "PH", courseNumber: 201) { result in
            switch result {
            case .success(let course):
                XCTAssertTrue(course.title!.contains("GENERAL PHYSICS"))
                XCTAssertNotNil(course.description)
                XCTAssertGreaterThan(course.sections.count, 0)
                expectation.fulfill()
            case .failure:
                XCTFail("Failed to retrieve course from Classmere API. Check network connection")
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testSearchBuildings() {
        let expectation = XCTestExpectation(description: "Search for Kelley Engineering from Classmere API")
        provider.search(building: "Kelley Engineering") { result in
            switch result {
            case .success(let searchResult):
                XCTAssertGreaterThan(searchResult.count, 0)
                expectation.fulfill()
            case .failure:
                XCTFail("Failed to search building from Classmere API. Check network connection")
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testSearchCourses() {
        let expectation = XCTestExpectation(description: "Search for English classes from Classmere API")
        provider.search(course: "English") { result in
            switch result {
            case .success(let searchResult):
                XCTAssertGreaterThan(searchResult.count, 0)
                expectation.fulfill()
            case .failure:
                XCTFail("Failed to search course from Classmere API. Check network connection")
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

}
