//
//  WelcomeSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class WelcomePAgeSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: WelcomePageSVC!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        main = WelcomePageSVC()
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testButtonPressed() {
        main.buttonPressed(tapGestureRecognizer: UITapGestureRecognizer())
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is SettingsTutorialsSVC)
    }
}

