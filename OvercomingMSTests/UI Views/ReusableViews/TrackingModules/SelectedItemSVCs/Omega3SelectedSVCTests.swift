//
//  Omega3SelectedSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class Omega3SelectedSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: Omega3SelectedItemSVC!
    var dbs: Omega3HistoryDBS!
    var item: Omega3HistoryDBT!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = Omega3HistoryDBS()
        main = Omega3SelectedItemSVC()
        
        item = Omega3HistoryDBT()
        item.Amount = 5
        item.supplementName = "Omega3"
        item.StartTime = Date()
        dbs.addItem(item: item)
        
        main.omega3Item = dbs.getTodaysOmega3Items()![0]
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testDisplaysValues() {
        XCTAssertEqual("Omega3", main.topMainLabel.text)
        XCTAssertEqual(OMSDateAccessor.getDateTime(date: item.StartTime), main.middleMainLabel.text)
        XCTAssertEqual("5 g", main.bottomMainLabel.text)
    }
    
    func testEditButtonPressed() {
        main.editButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        let page = parent.topView as! Omega3ModifySVC
        XCTAssertEqual(5, page.editingOmega3Item.Amount)
    }
    
    func testRepeatItemPressed() {
        main.repeatButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testRepeatItem() {
        main.repeatItem()
        
        XCTAssertEqual(2, dbs.getTodaysOmega3Items()!.count)
    }
    
    func testDeleteItemPressed() {
        main.repeatButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testDeleteItem() {
        main.deleteItem()
        
        XCTAssertEqual(0, dbs.getTodaysOmega3Items()!.count)
    }
    
}
