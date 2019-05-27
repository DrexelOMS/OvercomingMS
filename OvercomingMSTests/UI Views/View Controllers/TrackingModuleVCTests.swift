//
//  TrackingModuleVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class TrackingModuleVCTests: XCTestCase {
    
    var main: TrackingModuleVC!
    var initialMain = ExerciseMainSVC()
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        main = TrackingModuleVC(title: "Title", trackingDBS: TrackingModulesDBS(), mainViewToSet: initialMain)
    }
    
    func testTitleSet() {
        XCTAssertEqual("Title", main.progressBar.getTitle())
    }
    
    func testAddViews() {
        main.addViewsBeforeMain()
        
        XCTAssertEqual(main.theme, main.progressBar.colorTheme)
    }
}
