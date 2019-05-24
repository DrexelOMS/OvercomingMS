//
//  MedicationSelectedSVCTests.swift
//  OvercomingMSTests
//
//  Created by Cassandra Li on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import XCTest
@testable import OvercomingMS

class MedicationSelectedSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: MedicationSelectedItemSVC!
    var dbs: SavedMedicationDBS!
    var item: SavedMedicationDBT!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = SavedMedicationDBS()
        main = MedicationSelectedItemSVC()
        
        item = SavedMedicationDBT()
        item.MedicationName = "Red"
        item.TimeOfDay = Date()
        item.DateCreated = Date()
        item.MedicationNote="Smooth capsule"
        item.Frequency = "MTWRFSU"
        dbs.addItem(item: item)
        
        main.savedMedicationItem = dbs.getSavedMedicationItems().medicationsTracked[0]
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testDisplaysValues() {
        XCTAssertEqual("Red", main.topMainLabel.text)
        XCTAssertEqual(OMSDateAccessor.getDateTime(date: item.TimeOfDay), main.middleMainLabel.text)
        XCTAssertEqual("Everyday", main.middleFrequencyLabel.text)
        XCTAssertEqual("Smooth capsule", main.bottomMainLabel.text)
    }
    
    func testEditButtonPressed() {
        main.editButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        let page = parent.topView as! MedicationModifySVC
        XCTAssertEqual("Red", page.editingMedicationItem.MedicationName)
    }
    
    func testRepeatItemPressed() {
        main.repeatButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testRepeatItem() {
        main.repeatItem()
        
        XCTAssertEqual(2, dbs.getTodaysTotalMedGoal())
    }
    
    func testDeleteItemPressed() {
        main.deleteButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testDeleteItem() {
        main.deleteItem()
        
        XCTAssertEqual(0, dbs.getTodaysTotalMedGoal())
    }
    
}
