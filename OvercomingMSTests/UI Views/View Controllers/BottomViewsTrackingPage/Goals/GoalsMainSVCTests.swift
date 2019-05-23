//
//  GoalsMainSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class GoalsMainSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: GoalsMainSVC!
    var dbs: GoalsDBS!
    var item: Omega3HistoryDBT!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = GoalsDBS()
        main = GoalsMainSVC()
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testInitialGoalsAreSet() {
        XCTAssertEqual("Pretty good.", main.foodButton.goalDescription)
        XCTAssertEqual("20 g", main.omega3Button.goalDescription)
        XCTAssertEqual("10k IUs", main.vitaminDButton.goalDescription)
        XCTAssertEqual("30 min", main.exerciseButton.goalDescription)
        XCTAssertEqual("15 min", main.meditationButton.goalDescription)
    }
    
    func testFoodPressed() {
        main.foodPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is GoalsModifySVC)
    }
    
    func testOmega3Pressed() {
        main.omega3Pressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is GoalsModifySVC)
    }
    
    func testVitaminDPressed() {
        main.vitaminDPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is GoalsModifySVC)
    }
    
    func testExercisePressed() {
        main.exercisePressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is GoalsModifySVC)
    }
    
    func testMeditationPressed() {
        main.meditationPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is GoalsModifySVC)
    }
    
    func testResetPressed() {
        main.reset("")
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testReset() {
        ProgressBarConfig.exerciseGoal = 2
        XCTAssertEqual(2, ProgressBarConfig.exerciseGoal)
        
        main.resetGoalsToDefault()
        
        XCTAssertEqual(30, ProgressBarConfig.exerciseGoal)
    }
    
    
}
