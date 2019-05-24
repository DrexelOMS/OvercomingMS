//
//  DatePickerSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
import UIKit
import JTAppleCalendar
@testable import OvercomingMS

class DatePickerSVCTests: XCTestCase {
    
    var main: DatePickerSVC!
    var parent: MockSlidingStackVC!
    var todaysFullDate: Date!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        main = DatePickerSVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        todaysFullDate = OMSDateAccessor().todaysFullDate
    }
    
    func testBackToToday() {
        main.backToTodayPressed("")
        
        XCTAssertEqual(globalCurrentFullDate, todaysFullDate)
    }
    
}
