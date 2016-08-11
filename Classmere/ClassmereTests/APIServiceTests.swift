//
//  APIServiceTests.swift
//  Classmere
//
//  Created by Brandon Lee on 8/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import XCTest
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
        APIService.getAllCourses({ response in
            XCTAssertNotNil(response)
        })
    }
    
    func testGetCourseBySubjectCode() {
        APIService.getCourseBySubjectCode("CS", courseNumber: 161, completion: { response in
            XCTAssertNotNil(response)
        })
    }
    
    func testSearchCourse() {
        APIService.searchCourse("Computer Science", completion: { response in
            XCTAssertNotNil(response)
        })
    }
    
    func testGetBuildingByAbbr() {
        APIService.getBuildingByAbbr("KEC", completion: { response in
            XCTAssertNotNil(response)
        })
    }
    
    func testSearchBuilding() {
        APIService.searchBuilding("Kelley", completion: { response in
            XCTAssertNotNil(response)
        })
    }
}
