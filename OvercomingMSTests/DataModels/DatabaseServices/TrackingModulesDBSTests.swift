//
//  OvercomingMSTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/21/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class TrackingModulesDBSTests: XCTestCase {

    var service: TrackingModulesDBS!
    var date = "01/01/1996"
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        service = TrackingModulesDBS(editingDate: date)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModulesIsAbstract() {
        expectFatalError(expectedMessage: "Forgot to override module") {
            _ = self.service.module
        }
    }

    func testGetTrackingDay() {
        let day = service.getTrackingDay()
        XCTAssertEqual(date, day.DateCreated)
    }

}
