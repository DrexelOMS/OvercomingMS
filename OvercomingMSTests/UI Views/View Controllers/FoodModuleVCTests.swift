//
//  FoodModuleVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class FoodModuleVCTests: XCTestCase {
    
    var main: FoodModuleVC!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        main = FoodModuleVC(initialView: FoodMainSVC())
        main.loadView()
    }
    
    func testAddViews() {
        main.addViewsBeforeMain()
        
        XCTAssertNotNil(main.foodContainer)
    }
    
}
