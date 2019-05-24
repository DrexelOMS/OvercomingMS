//
//  FoodTests.swift
//  OvercomingMSTests
//
//  Created by Justin Ickler on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class FoodTests: XCTestCase {

    var main: Food!

    
    override func setUp() {
        main = Food()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCheckType(){
        let types : [String]
        types = ["Dairy","Dairies","Meat","Meats","Fat","Fats","Cheese","Poultry","Poultries","Beef","Beefs","Chicken","Chickens"]
        for str in types{
            let rlevel = main.checkType(type: str)
            XCTAssertEqual(rlevel,RecommendedLevel.Bad)
        }
        XCTAssertTrue(main.checkType(type: "Egg") == RecommendedLevel.Caution)
        XCTAssertTrue(main.checkType(type: "Eggs") == RecommendedLevel.Caution)
        XCTAssertTrue(main.checkType(type: "test") == RecommendedLevel.Good)
    }

}
