//
//  MeditationModifySVCTests.swift
//  OvercomingMSTests
//
//  Created by Julie Soderstrom on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class MeditationModifySVCTests: XCTestCase {
    var parent: MockSlidingStackVC!
    var main: MeditationModifySVC!
    var dbs: MeditationHistoryDBS!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = MeditationHistoryDBS()
    }
    
    func testAddItem(){
        main = MeditationModifySVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedType = "Meditation_Added"
        main.selectedLength = 10
        main.selectedStartTime = Date()
        
        main.ConfirmPressed()
        
        let minutes = dbs.getTotalMinutes()
        
        XCTAssertEqual(10, minutes)
    }
    
    func testEditItem() {
        let item = MeditationHistoryDBT()
        
        item.StartTime = Date()
        item.EndTime = item.StartTime.addingTimeInterval(120)
        item.MeditationType = "Meditation"
        dbs.addItem(item: item)
        
        main = MeditationModifySVC()
        main.editingMeditationItem = dbs.getTodaysMeditationItems()![0]
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedLength = 5
        
        main.ConfirmPressed()
        
        let amount = dbs.getTotalMinutes()
        
        XCTAssertEqual(5, amount)
    }}
