import XCTest
import Alamofire
import PureLayout
import SwiftyJSON
@testable import Classmere

class APIServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGetAllCourses() {
        _ = APIService.getAllCourses({ response in
            XCTAssertNotNil(response)
        })
    }
    
    func testGetCourseBySubjectCode() {
        _ = APIService.getCourseBySubjectCode("CS", courseNumber: 161, completion: { response in
            XCTAssertNotNil(response)
        })
    }
    
    func testSearchCourse() {
        _ = APIService.searchCourse("Computer Science", completion: { response in
            XCTAssertNotNil(response)
        })
    }
    
    func testGetBuildingByAbbr() {
        _ = APIService.getBuildingByAbbr("KEC", completion: { response in
            XCTAssertNotNil(response)
        })
    }
    
    func testSearchBuilding() {
        _ = APIService.searchBuilding("Kelley", completion: { response in
            XCTAssertNotNil(response)
        })
    }
    
    func testCourseModel() {
        _ = APIService.getCourseBySubjectCode("CS", courseNumber: 161, completion: { response in
            let course: Course = Course(courseJSON: response)
            XCTAssertNotNil(course.title)
            XCTAssertNotNil(course.subjectCode)
            XCTAssertNotNil(course.courseNumber)
            XCTAssertNotNil(course.credits)
            XCTAssertNotNil(course.description)
            XCTAssertNotNil(course.abbr)
            XCTAssertNotNil(course.sections)
        })
    }
    
    func testSectionModel() {
        _ = APIService.getCourseBySubjectCode("CS", courseNumber: 161, completion: { response in
            let course: Course = Course(courseJSON: response)
            let section: Section = course.sections[0]
            XCTAssertNotNil(section.term)
            XCTAssertNotNil(section.session)
            XCTAssertNotNil(section.crn)
            XCTAssertNotNil(section.credits)
            XCTAssertNotNil(section.instructor)
            XCTAssertNotNil(section.startTime)
            XCTAssertNotNil(section.endTime)
            XCTAssertNotNil(section.days)
            XCTAssertNotNil(section.buildingCode)
            XCTAssertNotNil(section.roomNumber)
            XCTAssertNotNil(section.startDate)
            XCTAssertNotNil(section.endDate)
            XCTAssertNotNil(section.campus)
            XCTAssertNotNil(section.type)
            XCTAssertNotNil(section.status)
            XCTAssertNotNil(section.enrollmentCapacity)
            XCTAssertNotNil(section.enrollmentCurrent)
            XCTAssertNotNil(section.waitlistCapacity)
            XCTAssertNotNil(section.waitlistCurrent)
            XCTAssertNotNil(section.fees)
            XCTAssertNotNil(section.restrictions)
            XCTAssertNotNil(section.comments)
            XCTAssertNotNil(section.textbookUrl)
        })
    }
    
    func testBuildingModel() {
        _ = APIService.getBuildingByAbbr("KEC", completion: { response in
            let building: Building = Building(buildingJSON: response)
            XCTAssertNotNil(building.abbr)
            XCTAssertNotNil(building.address)
            XCTAssertNotNil(building.buildingNumber)
            XCTAssertNotNil(building.name)
            XCTAssertNotNil(building.latitude)
            XCTAssertNotNil(building.longitude)
        })
    }
}
