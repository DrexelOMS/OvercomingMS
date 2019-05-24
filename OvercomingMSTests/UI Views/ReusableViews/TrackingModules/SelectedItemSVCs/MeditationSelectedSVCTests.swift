//
//  MeditationSelectedSVCTests.swift
//  OvercomingMSTests
//
//  Created by Cassandra Li on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import XCTest
@testable import OvercomingMS

class MeditationSelectedSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: MeditationSelectedItemSVC!
    var dbs: MeditationHistoryDBS!
    var item: MeditationHistoryDBT!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = MeditationHistoryDBS()
        main = MeditationSelectedItemSVC()
        
        item = MeditationHistoryDBT()
        item.MeditationType = "Silent"
        item.StartTime = Date()
        item.EndTime = Date().addingTimeInterval(60*30)
        dbs.addItem(item: item)
        
        main.meditationItem = dbs.getTodaysMeditationItems()![0]
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testDisplaysValues() {
        XCTAssertEqual("Silent", main.topMainLabel.text)
        XCTAssertEqual(OMSDateAccessor.getDateTime(date: item.StartTime), main.middleMainLabel.text)
        XCTAssertEqual("30 min", main.bottomMainLabel.text)
    }
    
    func testEditButtonPressed() {
        main.editButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        let page = parent.topView as! MeditationModifySVC
        XCTAssertEqual("Silent", page.editingMeditationItem.MeditationType)
    }
    
    func testRepeatItemPressed() {
        main.repeatButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testRepeatItem() {
        main.repeatItem()
        
        XCTAssertEqual(2, dbs.getTodaysMeditationItems()!.count)
    }
    
    func testDeleteItemPressed() {
        main.deleteButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testDeleteItem() {
        main.deleteItem()
        
        XCTAssertEqual(0, dbs.getTodaysMeditationItems()!.count)
    }
    
}
