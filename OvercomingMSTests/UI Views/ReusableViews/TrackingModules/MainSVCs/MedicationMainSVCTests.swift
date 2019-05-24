//
//  MedicationMainSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class MedicationMainSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: MedicationMainSVC!
    var dbs: SavedMedicationDBS!
    var trackedItem: SavedMedicationDBT!
    var untrackedItem: SavedMedicationDBT!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        globalCurrentFullDate = OMSDateAccessor().todaysFullDate
        
        dbs = SavedMedicationDBS()
        
        trackedItem = SavedMedicationDBT()
        trackedItem.MedicationName = "red"
        trackedItem.DateCreated = Date()
        trackedItem.TimeOfDay = Date()
        trackedItem.Frequency = "MTWRFSU"
        
        untrackedItem = SavedMedicationDBT()
        untrackedItem.MedicationName = "Blue"
        untrackedItem.DateCreated = Date()
        untrackedItem.TimeOfDay = Date()
        untrackedItem.Frequency = ""
        
        dbs.addItem(item: trackedItem)
        dbs.addItem(item: untrackedItem)
        
        main = MedicationMainSVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testAddButtonPressed() {
        main.addButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is MedicationModifySVC)
    }
    
    func testItemsDisplayed() {
        let cell1 = main.tableView(main.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! ExpandingCell
        let cell2 = main.tableView(main.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as! ExpandingCell
        
        XCTAssertEqual("\(OMSDateAccessor.getDateTime(date: trackedItem.TimeOfDay))", cell1.topLabel.text)
        XCTAssertEqual("Not Taking Today", cell2.topLabel.text)
    }    
    
}

