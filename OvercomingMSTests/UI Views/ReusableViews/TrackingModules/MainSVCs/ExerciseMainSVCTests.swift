//
//  ExerciseMainSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class ExerciseMainSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: ExerciseMainSVC!
    var dbs: ExerciseHistoryDBS!
    var item: ExerciseHistoryDBT!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = ExerciseHistoryDBS()
        
        item = ExerciseHistoryDBT()
        item.RoutineType = "Exercise"
        item.StartTime = Date()
        item.EndTime = item.StartTime.addingTimeInterval(5*60)
        
        dbs.addItem(item: item)
        
        main = ExerciseMainSVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testAddButtonPressed() {
        main.addButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ExerciseModifySVC)
    }
    
    func testTimerButtonPressed() {
        main.timerButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ExerciseStopwatchSVC)
    }
    
    func testItemsDisplayed() {
        let cell = main.tableView(main.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! Routine3PartCell
        
        XCTAssertEqual(item.RoutineType, cell.labelLeft.text)
        XCTAssertEqual("\(item.minutes) min", cell.labelRight.text)
    }
    
    func testItemWasPressed() {
        main.tableView(main.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is SelectedItemSVC)
    }
    
    
}
