//
//  ProgressBarConfigTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class ProgressBarConfigTests: XCTestCase {
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetFoodDescription() {
        let cases = [0,1,2,3,4]
        cases.forEach {
            XCTAssertEqual(ProgressBarConfig.foodDescriptions[$0], ProgressBarConfig.getfoodDescription(rating: $0 + 1))
        }
    }
    
    func testFoodDefaultGoal() {
        XCTAssertEqual(4, ProgressBarConfig.foodRatingGoal)
    }
    
    func testOmega3DefaultGoal() {
        XCTAssertEqual(20, ProgressBarConfig.omega3Goal)
    }
    
    func testVitaminDDefaultGoal() {
        XCTAssertEqual(10, ProgressBarConfig.vitaminDGoal)
    }
    
    func testExerciseDefaultGoal() {
        XCTAssertEqual(30, ProgressBarConfig.exerciseGoal)
    }
    
    func testMeditationDefaultGoal() {
        XCTAssertEqual(15, ProgressBarConfig.meditationGoal)
    }
    
}
