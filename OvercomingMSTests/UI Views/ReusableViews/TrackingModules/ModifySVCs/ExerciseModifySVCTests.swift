//
//  ExerciseModifySVCTests.swift
//  OvercomingMSTests
//
//  Created by Julie Soderstrom on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class ExerciseModifySVCTests: XCTestCase {
    var parent: MockSlidingStackVC!
    var main: ExerciseModifySVC!
    var dbs: ExerciseHistoryDBS!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = ExerciseHistoryDBS()
    }
    
    func testAddItem(){
        main = ExerciseModifySVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedType = "Exercise_Added"
        main.selectedLength = 10
        main.selectedStartTime = Date()
        
        main.ConfirmPressed()
        
        let minutes = dbs.getTotalMinutes()
        
        XCTAssertEqual(10, minutes)
    }
    
    func testEditItem() {
        let item = ExerciseHistoryDBT()
        
        item.StartTime = Date()
        item.EndTime = item.StartTime.addingTimeInterval(120)
        item.RoutineType = "Exercise"
        dbs.addItem(item: item)
        
        main = ExerciseModifySVC()
        main.editingExerciseItem = dbs.getTodaysExerciseItems()![0]
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedLength = 5
        
        main.ConfirmPressed()
        
        let amount = dbs.getTotalMinutes()
        
        XCTAssertEqual(5, amount)
    }}

