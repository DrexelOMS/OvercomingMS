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
//        XCTAssertTrue(slidingVCMock.wasPresented)
    }
    
    func testDidPressCheckMark_Food() {
        trackingBar.tag = 5
        
        main.didPressCheckButton(trackingBar)
        
        XCTAssertEqual(main.foodBar.colorTheme, main.foodBar.shadowedRoundedView!.backgroundColor)
    }

}
