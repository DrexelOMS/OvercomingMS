//
//  ExerciseStopwatchSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class ExerciseStopwatchSVCTests: XCTestCase {
    
    var main: ExerciseStopwatchSVC!
    var parent: MockSlidingStackVC!
    
    override func setUp() {
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        main = ExerciseStopwatchSVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testCancelButtonPressed(){
        main.cancelButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue((parent.topView is ConfirmationSVC))
    }
    
    func testStartPauseButton() {
        XCTAssertTrue(main.firstStart)
        main.startPauseButtonPressed()
        
        XCTAssertFalse(main.firstStart)
        XCTAssertEqual("Keep going!", main.descriptionLabel.text)
        XCTAssertTrue(main.isTimerRunning)
        
        main.startPauseButtonPressed()
        XCTAssertEqual("Workout paused.", main.descriptionLabel.text)
        XCTAssertFalse(main.isTimerRunning)
        
        main.startPauseButtonPressed()
        XCTAssertEqual("Keep going!", main.descriptionLabel.text)
        XCTAssertTrue(main.isTimerRunning)
    }
    
    func testUpdateTimer() {
        main.updateTimer()
        
        XCTAssertEqual(1, main.seconds)
    }
    
    func testFinishPressed_0_seconds() {
        main.finishButtonPressed()
        
        XCTAssertFalse(parent.pushWasCalled)
    }
    
    func testFinishPressed_1_seconds() {
        main.updateTimer()
        main.finishButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ExerciseModifySVC)
    }
    
}
