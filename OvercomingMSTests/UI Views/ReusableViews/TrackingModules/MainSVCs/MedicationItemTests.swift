//
//  Omega3MainSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class MedicationItemsSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: MedicationItemSVC!
    var dbs: SavedMedicationDBS!
    var trackedItem: SavedMedicationDBT!
    var untrackedItem: SavedMedicationDBT!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
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
    
        parent = MockSlidingStackVC(initialView: MedicationMainSVC())
        parent.viewDidLoad()
        
        main = MedicationItemSVC()
        main.parentVC = parent
        main.item = trackedItem
    }
    
    func testDoneButtonPressed() {
        main.doneCheckButton.IsDone = true
        main.doneButtonPressed(UIButton())
        
        XCTAssertFalse(main.doneCheckButton.IsDone)
        
        main.doneButtonPressed(UIButton())
        
        XCTAssertTrue(main.doneCheckButton.IsDone)
        
    }
    
    func testViewWasPressed() {
        main.viewPressed(tapGestureRecognizer: UITapGestureRecognizer())
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is MedicationSelectedItemSVC)
    }
    
    
    
    
}
