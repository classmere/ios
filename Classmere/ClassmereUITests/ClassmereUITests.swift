import XCTest

class ClassmereUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        setupSnapshot(app)
        app.launch()
    }

    func testGatherScreenshots() {
        snapshot("0home")

        app.buttons["Search for classes..."].tap()
        app.searchFields.element.typeText("CS 161")
        _ = app.tables.cells.staticTexts["CS 161 INTRODUCTION TO COMPUTER SCIENCE I"].waitForExistence(timeout: 5)
        snapshot("1search")

        app.tables.cells.staticTexts["CS 161 INTRODUCTION TO COMPUTER SCIENCE I"].tap()
        snapshot("2course")

        _ = app.tables.cells.staticTexts["Lecture"].waitForExistence(timeout: 5)
        app.tables.cells.staticTexts["Lecture"].firstMatch.tap()
        snapshot("3section")
    }
}
