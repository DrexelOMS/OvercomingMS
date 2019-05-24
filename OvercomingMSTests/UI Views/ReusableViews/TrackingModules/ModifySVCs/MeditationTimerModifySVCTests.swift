//
//  MeditationModifySVCTests.swift
//  OvercomingMSTests
//
//  Created by Julie Soderstrom on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class MeditatioTimernModifySVCTests: XCTestCase {
    var parent: MockSlidingStackVC!
    var main: MeditationTimerModifySVC!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
    }
    
    func testConfirmPressed(){
        main = MeditationTimerModifySVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedLength = 5
        
        main.ConfirmPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is MeditationTimerSVC)
    }

}
