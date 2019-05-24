//
//  ExerciseSelectedSVCTests.swift
//  OvercomingMSTests
//
//  Created by Cassandra Li on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import XCTest
@testable import OvercomingMS

class ExerciseSelectedSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: ExerciseSelectedItemSVC!
    var dbs: ExerciseHistoryDBS!
    var item: ExerciseHistoryDBT!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = ExerciseHistoryDBS()
        main = ExerciseSelectedItemSVC()
        
        item = ExerciseHistoryDBT()
        item.RoutineType = "Run"
        item.StartTime = Date()
        item.EndTime = Date().addingTimeInterval(60*30)
        dbs.addItem(item: item)
        
        main.exerciseItem = dbs.getTodaysExerciseItems()![0]
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testDisplaysValues() {
        XCTAssertEqual("Run", main.topMainLabel.text)
        XCTAssertEqual(OMSDateAccessor.getDateTime(date: item.StartTime), main.middleMainLabel.text)
        XCTAssertEqual("30 min", main.bottomMainLabel.text)
    }
    
    func testEditButtonPressed() {
        main.editButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        let page = parent.topView as! ExerciseModifySVC
        XCTAssertEqual("Run", page.editingExerciseItem.RoutineType)
    }
    
    func testRepeatItemPressed() {
        main.repeatButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testRepeatItem() {
        main.repeatItem()
        
        XCTAssertEqual(2, dbs.getTodaysExerciseItems()!.count)
    }
    
    func testDeleteItemPressed() {
        main.deleteButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testDeleteItem() {
        main.deleteItem()
        
        XCTAssertEqual(0, dbs.getTodaysExerciseItems()!.count)
    }
    
}
