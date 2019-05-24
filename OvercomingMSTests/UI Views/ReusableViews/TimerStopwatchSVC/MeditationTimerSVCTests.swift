//
//  ExerciseStopwatchSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class MeditationTimerSVCTests: XCTestCase {
    
    var main: MeditationTimerSVC!
    var parent: MockSlidingStackVC!
    
    override func setUp() {
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        main = MeditationTimerSVC(startingSeconds: 5, meditationType: "Seed")
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
        XCTAssertEqual("Currently Playing", main.descriptionLabel.text)
        XCTAssertTrue(main.isTimerRunning)
        
        main.startPauseButtonPressed()
        XCTAssertEqual("Session paused", main.descriptionLabel.text)
        XCTAssertFalse(main.isTimerRunning)
        
        main.startPauseButtonPressed()
        XCTAssertEqual("Currently Playing", main.descriptionLabel.text)
        XCTAssertTrue(main.isTimerRunning)
    }
    
    func testStartingSound() {
        XCTAssertEqual("5_Minute", main.guidedSound)
        
        main = MeditationTimerSVC(startingSeconds: 15, meditationType: "Sprout")
        XCTAssertEqual("15_Minute", main.guidedSound)
        
        main = MeditationTimerSVC(startingSeconds: 5, meditationType: "Flower")
        XCTAssertEqual("35_Minute", main.guidedSound)
        
        main = MeditationTimerSVC(startingSeconds: 5, meditationType: "Tree")
        XCTAssertEqual("45_Minute", main.guidedSound)
    }
    
    func testUpdateTimer() {
        
        main.updateTimer()
        
        XCTAssertEqual(4, main.seconds)
    }
    
    func testPlaySound() {
        main.playSound(soundName: "5_Minute")
        
        XCTAssertTrue(main.player!.isPlaying)
    }
    
    func testFinishPressed_0_seconds() {
        
        main.finishButtonPressed()
        
        XCTAssertFalse(parent.pushWasCalled)
    }
    
    func testFinishPressed_1_seconds() {
        
        main.updateTimer()
        main.finishButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is MeditationModifySVC)
    }
    
}
