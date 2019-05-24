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
        item.MedicationName = "VitaminD"
        item.TimeOfDay = Date()
        item.DateCreated = Date()
        item.MedicationNote="Smooth capsule"
        item.Frequency = "MTWRFSU"
        dbs.addItem(item: item)
        
        main.savedMedicationItem = dbs.getSavedMedicationItems()[0]
        //main.savedMedicationItem = dbs.getTodaysTotalMedGoal()
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testDisplaysValues() {
        XCTAssertEqual("VitaminD", main.topMainLabel.text)
        XCTAssertEqual(OMSDateAccessor.getDateTime(date: item.StartTime), main.middleMainLabel.text)
        XCTAssertEqual("5k IUs", main.bottomMainLabel.text)
    }
    
    func testEditButtonPressed() {
        main.editButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        let page = parent.topView as! VitaminDModifySVC
        XCTAssertEqual(5, page.editingVitamindDItem.Amount)
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
