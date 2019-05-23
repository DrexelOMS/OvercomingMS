//
//  MainTrackingVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class MainTrackingVCTests: XCTestCase {
    
    var main: MainTrackingVC!
    var trackingBar: TrackingProgressBar!
    
    var ncMock: MockNotificationCenter!
    var slidingVCMock: MockSlidingStackVC!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        main = storyboard.instantiateViewController(withIdentifier: "MainTrackingVC") as? MainTrackingVC
        main.loadView() // This line is the key
        
        trackingBar = TrackingProgressBar()
        
        ncMock = MockNotificationCenter()
        main.notificationCenter = ncMock
        
        slidingVCMock = MockSlidingStackVC()
        main.onboardingVC = slidingVCMock
        
    }
    
    func testTodaysDate() {
        XCTAssertEqual(OMSDateAccessor().todaysDate, main.todaysDate)
    }
    
    func testViewWillAppear() {
        main.viewWillAppear(false)
        XCTAssertEqual(2, ncMock.addObserverWasCalled)
    }
    
    func testViewWillDisappear() {
        main.viewWillDisappear(false)
        XCTAssertEqual(2, ncMock.removeObserverWasCalled)
    }
    
    func testAttemptHeaderRestore_today_to_previous_day() {
        main.previousDate(gesture: UIGestureRecognizer())
        XCTAssertEqual("You are editing a past day!", main.header.messageLabel.text)
    }
    
    func testAttempHeaderRestore_previous_date_to_today() {
        main.previousDate(gesture: UIGestureRecognizer())
        main.nextDate(gesture: UIGestureRecognizer())
        
//        XCTAssertNotEqual("You are editing a past day!", main.header.messageLabel.text)
    }
    
    func testOnboardingCheck() {
        main.onboardingCheck()
        
        XCTAssertTrue(main.onboardingVC.initialView is WelcomePageSVC)
    }
    
    func testDidPressCheckMark_Food() {
        trackingBar.tag = 5
        
        main.didPressCheckButton(trackingBar)
        
        XCTAssertEqual(main.foodBar.colorTheme, main.foodBar.shadowedRoundedView!.backgroundColor)
    }
    
    func testDidPressCheckMark_Omega3() {
        trackingBar.tag = 0
        
        main.didPressCheckButton(trackingBar)
        
        XCTAssertEqual(main.omega3Bar.colorTheme, main.omega3Bar.shadowedRoundedView!.backgroundColor)
    }
    
    func testDidPressCheckMark_VitaminD() {
        trackingBar.tag = 1
        
        main.didPressCheckButton(trackingBar)
        
        XCTAssertEqual(main.vitaminDBar.colorTheme, main.vitaminDBar.shadowedRoundedView!.backgroundColor)
    }
    
    func testDidPressCheckMark_Exercise() {
        trackingBar.tag = 2
        
        main.didPressCheckButton(trackingBar)
        
        XCTAssertEqual(main.exerciseBar.colorTheme, main.exerciseBar.shadowedRoundedView!.backgroundColor)
    }
    
    func testDidPressCheckMark_Meditation() {
        trackingBar.tag = 3
        
        main.didPressCheckButton(trackingBar)
        
        XCTAssertEqual(main.meditationBar.colorTheme, main.meditationBar.shadowedRoundedView!.backgroundColor)
    }
    
    func testDidPressCheckMark_Medications() {
        trackingBar.tag = 4
        
        main.didPressCheckButton(trackingBar)
        
        XCTAssertEqual(main.medicationBar.colorTheme, main.medicationBar.shadowedRoundedView!.backgroundColor)
    }
    
    func testDidPressLeft_Food() {
        trackingBar.tag = 5
        
        main.didPressLeftContainer(trackingBar)
        
        XCTAssertTrue(main.moduleVC is FoodModuleVC)
    }
    
    func testDidPressLeft_Omega3() {
        trackingBar.tag = 0
        
        main.didPressLeftContainer(trackingBar)
        
        XCTAssertTrue(main.moduleVC is TrackingModuleVC)
        let tracking = main.moduleVC as! TrackingModuleVC
        XCTAssertTrue(tracking.trackingDBS is Omega3HistoryDBS)
    }
    
    func testDidPressLeft_VitaminD() {
        trackingBar.tag = 1
        
        main.didPressLeftContainer(trackingBar)
        
        XCTAssertTrue(main.moduleVC is TrackingModuleVC)
        let tracking = main.moduleVC as! TrackingModuleVC
        XCTAssertTrue(tracking.trackingDBS is VitaminDHistoryDBS)
    }
    
    func testDidPressLeft_Exercise() {
        trackingBar.tag = 2
        
        main.didPressLeftContainer(trackingBar)
        
        XCTAssertTrue(main.moduleVC is TrackingModuleVC)
        let tracking = main.moduleVC as! TrackingModuleVC
        XCTAssertTrue(tracking.trackingDBS is ExerciseHistoryDBS)
    }
    
    func testDidPressLeft_Meditation() {
        trackingBar.tag = 3
        
        main.didPressLeftContainer(trackingBar)
        
        XCTAssertTrue(main.moduleVC is TrackingModuleVC)
        let tracking = main.moduleVC as! TrackingModuleVC
        XCTAssertTrue(tracking.trackingDBS is MeditationHistoryDBS)
    }
    
    func testDidPressLeft_Medications() {
        trackingBar.tag = 4
        
        main.didPressLeftContainer(trackingBar)
        
        XCTAssertTrue(main.moduleVC is TrackingModuleVC)
        let tracking = main.moduleVC as! TrackingModuleVC
        XCTAssertTrue(tracking.trackingDBS is SavedMedicationDBS)
    }
    
    func testProgressDayPressed() {
        main.ProgressDayPressed(gesture: UIGestureRecognizer())
        
        XCTAssertTrue(main.dataPicker.initialView is DatePickerSVC)
    }
    
    func testGoalsPressed() {
        globalCurrentFullDate = OMSDateAccessor().todaysFullDate
        main.goalPressed()
        
        XCTAssertTrue(main.goalSVC.initialView is GoalsMainSVC)
    }
    
    func testGoalsPressed_while_not_today() {
        globalCurrentFullDate = OMSDateAccessor().todaysFullDate.addingTimeInterval(-24*60*60)
        main.goalPressed()
        
        XCTAssertNil(main.goalSVC)
    }
    
    func testSymptomsPressed() {
        main.symptomsPressed()
        
        XCTAssertTrue(main.symptomsSVC.initialView is SymptomsMainSVC)
    }
    
    func testSettingsPressed() {
        main.settingsPressed()
        
        XCTAssertTrue(main.settingsSVC.initialView is SettingsMainSVC)
    }

}
