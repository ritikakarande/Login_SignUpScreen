//
//  Sprint1UITests.swift
//  Sprint1UITests
//
//  Created by Capgemini-DA087 on 8/25/22.
//

import XCTest

class Sprint1UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        //XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.buttons["Login"].tap()
        XCTAssertNotNil(app.alerts, "Alert not shown")
        
        XCTAssert(app.navigationBars["Employees"].exists, "Employee view does not exist")
        app.cells.firstMatch.tap()
        XCTAssert(app.staticTexts["Hello"].exists, "Hello label does not exist")
        XCTAssert(app.staticTexts["ritika Karande"].exists, "name label does not exist")
        
        
        //XCTAssertEqual(app.staticTexts["Hello"].label, "Hello")
        //XCTAssertEqual(app.staticTexts["ritika Karande"].label, "ritika Karande")
      
        
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSignUp() throws{
        let app = XCUIApplication()
        app.launch()
        app.buttons["Sign Up"].tap()
        XCTAssert(app.textFields["Name"].exists, "Name textfield doesn't exist")
        XCTAssert(app.textFields["Email Id"].exists, "Email Id textfield doesn't exist")
        XCTAssert(app.textFields["Mobile"].exists, "Mobile textfield doesn't exist")
        XCTAssert(app.secureTextFields["Password"].exists, "Password textfield doesn't exist")
        XCTAssert(app.secureTextFields["Confirm Password"].exists, "Confirm Password textfield not present")

    }
    func testNetworkCall() throws{
        let app = XCUIApplication()
        app.launch()
        app.buttons["Network Call"].tap()
        XCTAssert(app.buttons["Person"].exists, "Person button does not exist")
        app.buttons["Person"].tap()
        XCTAssert(app.buttons["Person Json"].exists, "Person Json button does not exist")
        app.buttons["Person Json"].tap()
        
    }
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
                //let app = XCUIApplication()
               

                
            }
        }
    }
}
