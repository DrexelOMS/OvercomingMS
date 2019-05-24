//
//  MedicationRateModel.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class MedicationRateModelTests: XCTestCase {
    
    var model: MedicationRateModel!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        model = MedicationRateModel(rateString: "MTWRFSU")
    }
    
    func testRateString() {
        model.rateString = "MTW"
        
        XCTAssertTrue(model.rateString.contains("M"))
        XCTAssertTrue(model.rateString.contains("T"))
        XCTAssertTrue(model.rateString.contains("W"))
    }
    
    func testIsEverday() {
        XCTAssertTrue(model.isEveryDay())
    }
    
    func testAttributedString() {
        var attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor.black];
        var myString = NSMutableAttributedString(string: "Everyday", attributes: attributedStringColor)
        
        XCTAssertEqual(myString, model.attributedString())
    }
}
