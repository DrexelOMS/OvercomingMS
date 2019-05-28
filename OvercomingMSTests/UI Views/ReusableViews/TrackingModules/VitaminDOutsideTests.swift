//
//  VitaminDOutsideTests.swift
//  OvercomingMSTests
//
//  Created by user150052 on 5/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//
//


import XCTest
@testable import OvercomingMS

class VitaminDOutsideTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: OutsideSVC!
    
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()

        main = OutsideSVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testBackButtonPressed() {
        main.backButtonPressed()
        XCTAssertTrue(parent.popWasCalled)
    }
    
}


