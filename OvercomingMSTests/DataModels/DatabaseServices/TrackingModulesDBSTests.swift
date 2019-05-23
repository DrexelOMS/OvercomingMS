//
//  OvercomingMSTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/21/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class TrackingModulesDBSTests: XCTestCase {

    var service: TrackingModulesDBS!
    var date = "01/01/1996"
    var mockNC: MockNotificationCenter!
    
    override func setUp() {
        //Make sure this runs first
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        service = TrackingModulesDBS(editingDate: date)
        mockNC = MockNotificationCenter()
        service.notificationCenter = MockNotificationCenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModulesIsAbstract() {
        expectFatalError(expectedMessage: "Forgot to override module") {
            _ = self.service.module
        }
    }

    func testGetTrackingDay() {
        let day = service.getTrackingDay()
        XCTAssertEqual(date, day.DateCreated)
    }
    
//    func testCheckToNotify_was_called_if_old_under_100() {
//        expectFatalError(expectedMessage: "getPercentageComplete not overriden") {
//            self.service.checkToNotify(oldPercent: 50)
//        }
//    }
    
    func testCheckToNotify_was_not_called_if_100() {
        service.checkToNotify(oldPercent: 100)
        XCTAssertFalse(mockNC.postWasCalled)
    }
    
    func testUpdateAllStatus_DoesNotFail() {
//        let mock1 = MockTrackingModulesDBS()
//        let mock2 = MockTrackingModulesDBS()
//        let mock3 = MockTrackingModulesDBS()
//        let mock4 = MockTrackingModulesDBS()
//        let mock5 = MockTrackingModulesDBS()
//        let mock6 = MockTrackingModulesDBS()
//        
//        service.FoodDBS = mock1
//        service.Omega3DBS = mock2
//        service.VitaminDDBS = mock3
//        service.ExerciseDBS = mock4
//        service.MeditationDBS = mock5
//        service.MedicationDBS = mock6
        
        service.updateAllStatus()

//        XCTAssertTrue(mock1.updateCompleteStatusCalled)
//        XCTAssertTrue(mock2.updateCompleteStatusCalled)
//        XCTAssertTrue(mock3.updateCompleteStatusCalled)
//        XCTAssertTrue(mock4.updateCompleteStatusCalled)
//        XCTAssertTrue(mock5.updateCompleteStatusCalled)
//        XCTAssertTrue(mock6.updateCompleteStatusCalled)
        
    }
    
    func testGetTotalPerfectDays_0() {
        XCTAssertEqual(0, service.getTotalPerfectDays())
    }
    
    func testGetTotalPerfectDays_2() {
        FoodRatingDBS().addQuickCompleteItem()
        Omega3HistoryDBS().addQuickCompleteItem()
        VitaminDHistoryDBS().addQuickCompleteItem()
        ExerciseHistoryDBS().addQuickCompleteItem()
        MeditationHistoryDBS().addQuickCompleteItem()
        SavedMedicationDBS().addQuickCompleteItem()
        
        globalCurrentFullDate = OMSDateAccessor.getFullDate(date: "01/02/1996")
        
        FoodRatingDBS().addQuickCompleteItem()
        Omega3HistoryDBS().addQuickCompleteItem()
        VitaminDHistoryDBS().addQuickCompleteItem()
        ExerciseHistoryDBS().addQuickCompleteItem()
        MeditationHistoryDBS().addQuickCompleteItem()
        SavedMedicationDBS().addQuickCompleteItem()
        
        XCTAssertEqual(2, service.getTotalPerfectDays())
    }
    
    func testDeleteItem() {
        let item = service.getTrackingDay()
        service.deleteItem(item: item)
        XCTAssertEqual(date, service.getTrackingDay().DateCreated)
    }

}
