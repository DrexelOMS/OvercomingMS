////
////  DisplayedMedicationItemsTests.swift
////  OvercomingMSTests
////
////  Created by Vincent Finn on 5/22/19.
////  Copyright © 2019 DrexelOMS. All rights reserved.
////
//
//import XCTest
//@testable import OvercomingMS
//import RealmSwift
//
//class DisplayedMedicationItemsTests: XCTestCase {
//    
//    var model: DisplayedMedicationItems!
//    var list1 = List<SavedMedicationDBT>()
//    var list2 = List<SavedMedicationDBT>()
//    
//    var tmed1 = SavedMedicationDBT()
//    var tmed2 = SavedMedicationDBT()
//    var umed1 = SavedMedicationDBT()
//    
//    override func setUp() {
//        //Only use these lines if you need to reset the database between tests
//        cleanAllData()
//        AppDelegate().firstTimeInitializers()
//        
//        tmed1.DateCreated = OMSDateAccessor.getFullDate(date: "01/01/1996")
//        tmed2.DateCreated = OMSDateAccessor.getFullDate(date: "01/02/1996")
//        umed1.DateCreated = OMSDateAccessor.getFullDate(date: "01/01/1996")
//    }
//    
//    func testHasUnTrackedMeds_true() {
//        list1.append(tmed1)
//        list1.append(tmed2)
//        list2.append(umed1)
//        model = DisplayedMedicationItems(trackedMeds: list1, untrackedMeds: list2)
//        
//        XCTAssertTrue(model.hasUntrackedMeds())
//    }
//    
//    func testHasUnTrackedMeds_false() {
//        model = DisplayedMedicationItems(trackedMeds: list1, untrackedMeds: list2)
//        XCTAssertFalse(model.hasUntrackedMeds())
//    }
//    
//    func testGetTotalMedCount() {
//        list1.append(tmed1)
//        list1.append(tmed2)
//        list2.append(umed1)
//        model = DisplayedMedicationItems(trackedMeds: list1, untrackedMeds: list2)
//        
//        XCTAssertEqual(3, model.getTotalMedCount())
//    }
//    
//}
