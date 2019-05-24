//
//  SettingsTrackingOnOfSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class SettingsTrackingSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: SettingsTrackingSVC!
    var dbs: ActiveTrackingDBS!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = ActiveTrackingDBS()
        
        main = SettingsTrackingSVC()
    }
    
    func testBackPressed() {
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.backPressed()
        
        XCTAssertTrue(parent.popWasCalled)
    }
    
    func testFoodToggledOff() {
        main.foodToggled(isOn: false)
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsFoodActive)
    }
    
    func testFoodToggledOn() {
        dbs.foodIsActive = false
        dbs.writeActiveItems()
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsFoodActive)
        
        main.foodToggled(isOn: true)
        
        XCTAssertTrue(dbs.mostRecentActiveTracking.IsFoodActive)
    }
    
    func testOmega3ToggledOff() {
        main.omega3Toggled(isOn: false)
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsOmega3Active)
    }
    
    func testOmega3ToggledOn() {
        dbs.omega3IsActive = false
        dbs.writeActiveItems()
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsOmega3Active)
        
        main.omega3Toggled(isOn: true)
        
        XCTAssertTrue(dbs.mostRecentActiveTracking.IsOmega3Active)
    }
    
    func testVitaminDToggledOff() {
        main.vitaminDToggled(isOn: false)
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsVitaminDActive)
    }
    
    func testVitaminDToggledOn() {
        dbs.vitaminDIsActive = false
        dbs.writeActiveItems()
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsVitaminDActive)
        
        main.vitaminDToggled(isOn: true)
        
        XCTAssertTrue(dbs.mostRecentActiveTracking.IsVitaminDActive)
    }
    
    func testExerciseToggledOff() {
        main.exerciseToggled(isOn: false)
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsExerciseActive)
    }
    
    func testExerciseToggledOn() {
        dbs.exerciseIsActive = false
        dbs.writeActiveItems()
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsExerciseActive)
        
        main.exerciseToggled(isOn: true)
        
        XCTAssertTrue(dbs.mostRecentActiveTracking.IsExerciseActive)
    }
    
    func testMeditationToggledOff() {
        main.meditationToggled(isOn: false)
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsMeditationActive)
    }
    
    func testMeditationToggledOn() {
        dbs.meditationIsActive = false
        dbs.writeActiveItems()
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsMeditationActive)
        
        main.meditationToggled(isOn: true)
        
        XCTAssertTrue(dbs.mostRecentActiveTracking.IsMeditationActive)
    }
    
    func testMedicationToggledOff() {
        main.medicationToggled(isOn: false)
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsMedicationActive)
    }
    
    func testMedicationToggledOn() {
        dbs.medicationIsActive = false
        dbs.writeActiveItems()
        
        XCTAssertFalse(dbs.mostRecentActiveTracking.IsMedicationActive)
        
        main.medicationToggled(isOn: true)
        
        XCTAssertTrue(dbs.mostRecentActiveTracking.IsMedicationActive)
    }
    
    
    
}
