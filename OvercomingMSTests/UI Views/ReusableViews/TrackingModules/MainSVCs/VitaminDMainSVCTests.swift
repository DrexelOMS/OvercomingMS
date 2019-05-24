//
//  VitaminDMainSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class VitaminDMainSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: VitaminDMainSVC!
    var dbs: VitaminDHistoryDBS!
    var item: VitaminDHistoryDBT!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = VitaminDHistoryDBS()
        
        item = VitaminDHistoryDBT()
        item.Amount = 5
        item.VitaminDType = "VitaminD"
        item.StartTime = Date()
        
        dbs.addItem(item: item)
        
        main = VitaminDMainSVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testAddButtonPressed() {
        main.addButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is VitaminDModifySVC)
    }
    
    func testSupplementButtonPressed() {
        main.supplementButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        let view = parent.topView as! VitaminDModifySVC
        XCTAssertTrue(view.isSupplementPage)
    }
    
    func testItemsDisplayed() {
        let cell = main.tableView(main.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! Routine3PartCell
        
        XCTAssertEqual(item.VitaminDType, cell.labelLeft.text)
        XCTAssertEqual("\(item.Amount)k IUs", cell.labelRight.text)
    }
    
    func testItemWasPressed() {
        main.tableView(main.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is SelectedItemSVC)
    }
    
    func testOutsideWasPressed() {
        main.outsideButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is OutsideSVC)
    }
    
}

