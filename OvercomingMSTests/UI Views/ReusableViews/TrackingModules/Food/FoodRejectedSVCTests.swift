//
//  FoodRejectedSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class FoodRejectedTests: XCTestCase {
    
    var main: FoodRejectedSVC!
    
    var methodWasCalled = false
    
    func method() {
        methodWasCalled = true
    }
    
    override func setUp() {
        main = FoodRejectedSVC(_badLabels: ["chicken"], seeMoreMethod: method)
    }
    
    func testTableReturnsCell() {
        main.tableView.reloadData()
        let cell = main.tableView(main.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! BadIngredientsCell
        
        XCTAssertEqual("chicken", cell.label.text)
    }
    
    func testSeeMoveButtonPressed() {
        main.seeMoreButton("")

        XCTAssertTrue(methodWasCalled)
    }
    
    

}
