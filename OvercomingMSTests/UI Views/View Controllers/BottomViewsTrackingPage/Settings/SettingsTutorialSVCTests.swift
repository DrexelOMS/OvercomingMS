//
//  SettingsTutorialSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class SettingsTutorialSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: SettingsTutorialsSVC!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        main = SettingsTutorialsSVC(isOnboarding: false)
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testPlay() {
        main.play()
        
        let expected = URL(fileURLWithPath: Bundle.main.path(forResource: "Tutorial720", ofType:"mov")!)
        let actual = main.player.url!
        
        XCTAssertEqual(expected, actual)
    }
    
    func testBackPressed_isOnboarding() {
        main.play()
        main.isOnboarding = true
        main.backPressed(tapGestureRecognizer: UITapGestureRecognizer())
        
        XCTAssertFalse(parent.dismissWasCalled)
        
        main.pause()
        
    }
    
    func testBackPressed_not_isOnboarding() {
        main.play()
        main.isOnboarding = false
        main.backPressed(tapGestureRecognizer: UITapGestureRecognizer())
        
        XCTAssertTrue(parent.popWasCalled)
        
    }
}
