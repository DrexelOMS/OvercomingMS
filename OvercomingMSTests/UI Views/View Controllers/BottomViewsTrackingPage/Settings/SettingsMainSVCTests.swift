
//
//  SettingsSVCTess.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class SettingsMainSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: SettingsMainSVC!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        main = SettingsMainSVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testTrackingPressed() {
        main.trackingPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is SettingsTrackingSVC)
    }
    
    func testTutorialsPressed() {
        main.tutorialsPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is SettingsTutorialsSVC)
    }
    
    
}
