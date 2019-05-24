//
//  MedicationModifySVCTests.swift
//  OvercomingMSTests
//
//  Created by Julie Soderstrom on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class MedicationModifySVCTests: XCTestCase {
    var parent: MockSlidingStackVC!
    var main: MedicationModifySVC!
    var dbs: SavedMedicationHistoryDBS!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = SavedMedicationHistoryDBS()
    }
    
    func testAddItem(){
        main = MedicationModifySVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedName = "Medication_Added"
        main.selectedNote = "med1"
        main.selectedRate = "MTWRFSU"
        main.selectedStartTime = Date()
        
        main.ConfirmPressed()
        
        //not entirely sure if this is the best way to check
        let meds = dbs.getTodaysTotalMedGoal()
        
        XCTAssertEqual(1, meds)
    
    }
    
    func testEditItem() {
        let item = SavedMedicationHistoryDBT()
        item.Frequency = "MTWRFSU"
        item.MedicationName = "Medication"
        item.TimeOfDay = Date()
        item.MedicationNote = "Replace med1"
        dbs.addItem(item: item)
        
        main = MedicationModifySVC()
        main.editingMedicationItem = dbs.getSavedMedicationItems()![0]
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.ConfirmPressed()
        
        let meds = dbs.getTodaysTotalMedGoal()
        
        XCTAssertEqual(1, meds)
    }}
