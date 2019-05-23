//
//  Omega3MainSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class Omega3MainSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: Omega3MainSVC!
    var dbs: Omega3HistoryDBS!
    var item: Omega3HistoryDBT!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = Omega3HistoryDBS()
        
        item = Omega3HistoryDBT()
        item.Amount = 5
        item.supplementName = "Omega3"
        item.StartTime = Date()
        
        dbs.addItem(item: item)
        
        main = Omega3MainSVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testAddButtonPressed() {
        main.addButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is Omega3ModifySVC)
    }
    
    func testSupplementButtonPressed() {
        main.supplementButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        let view = parent.topView as! Omega3ModifySVC
        XCTAssertTrue(view.isSupplementPage)
    }
    
    func testItemsDisplayed() {
        let cell = main.tableView(main.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! Routine3PartCell
        
        XCTAssertEqual(item.supplementName, cell.labelLeft.text)
        XCTAssertEqual("\(item.Amount) g", cell.labelRight.text)
    }
    
    func testItemWasPressed() {
        main.tableView(main.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is SelectedItemSVC)
    }
    
    
}
