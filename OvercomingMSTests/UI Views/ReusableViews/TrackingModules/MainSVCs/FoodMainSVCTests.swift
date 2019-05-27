//
//  FoodMainSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class FoodMainSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: FoodMainSVC!
    var dbs: FoodRatingDBS!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = FoodRatingDBS()
        
        main = FoodMainSVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testImagePressed() {
        main.imagePressed(tapGestureRecognizer: UITapGestureRecognizer())
        
        XCTAssertTrue(parent.presentWasCalled)
    }
    
    func testSearchPressed() {
        main.searchButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is FoodSearchSVC)
    }
    
    func testRecipiesButtonPressed() {
        main.recipesButtonPressed()
        
        XCTAssertTrue(parent.presentWasCalled)
    }
    
    func testScanButtonPressed() {
        main.scanButtonPressed()
        
        XCTAssertTrue(parent.presentWasCalled)
    }
    
    func testScannerDidDismiss() {
        main.scannerDidDismiss(main.barcodeScannerVC)
        
        XCTAssertNotNil(main.foodinfo)
    }
    
    func testScannerDidCapture() {
        main.scanner(main.barcodeScannerVC, didCaptureCode: "100", type: "barcode")
        
        XCTAssertEqual("100", main.capturedCode)
    }
    
}
