//
//  MyCommentUITests.swift
//  MyCommentUITests
//
//  Created by Mac on 29/10/2019.
//  Copyright © 2019 Pavel CH.V. All rights reserved.
//

import XCTest

class MyCommentUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        
        app = XCUIApplication ()
        app.launch ()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testExample() {
        
        app = XCUIApplication()
        XCTAssertTrue(app.isOmMainView)
        app.textFields["NameComment"].tap()
        app.textFields["NameComment"].typeText("какая хорошая погода")
        
        XCTAssertFalse(app.isOmMainView)
        app.buttons["Send"].tap()
        
        XCTAssertFalse(app.isOmMainView)
        app.buttons["Unload"].tap()

        XCTAssertTrue(app.tables.staticTexts["какая хорошая погода"].exists)
      
        
        
        // UI tests must launch the application that they test.
        /*
         2019-10-29 17:33:51.913651+0300 MyCommentUITests-Runner[13977:249806] Running tests...
         Test Suite 'Selected tests' started at 2019-10-29 17:33:53.658
         Test Suite 'MyCommentUITests.xctest' started at 2019-10-29 17:33:53.664
         Test Suite 'MyCommentUITests' started at 2019-10-29 17:33:53.669
         Test Case '-[MyCommentUITests.MyCommentUITests testExample]' started.
         t =     0.01s Start Test at 2019-10-29 17:33:53.715
         t =     0.24s Set Up
         t =     0.32s Open Pavel CH.V.
         t =     0.49s     Launch Pavel CH.V.
         t =     6.87s         Setting up automation session
         t =     9.68s         Wait for Pavel CH.V. to idle
         t =    11.99s Tear Down
         Test Case '-[MyCommentUITests.MyCommentUITests testExample]' passed (12.202 seconds).
         Test Suite 'MyCommentUITests' passed at 2019-10-29 17:34:05.913.
         Executed 1 test, with 0 failures (0 unexpected) in 12.202 (12.243) seconds
         Test Suite 'MyCommentUITests.xctest' passed at 2019-10-29 17:34:05.924.
         Executed 1 test, with 0 failures (0 unexpected) in 12.202 (12.260) seconds
         Test Suite 'Selected tests' passed at 2019-10-29 17:34:05.925.
         Executed 1 test, with 0 failures (0 unexpected) in 12.202 (12.266) seconds
         
         */
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}


extension XCUIApplication {
    var isOmMainView: Bool {
        return otherElements["mainView"].exists
    }
}
