//
//  FoodSearchSVCTests.swift
//  OvercomingMSTests
//
//  Created by Justin Ickler on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class FoodSearchSVCTests: XCTestCase {

    var main: FoodSearchSVC!
    var parent: MockSlidingStackVC!
    var food: Food!

    override func setUp() {
        main = FoodSearchSVC()
        main.foodItemsArray = [Food]()
        food = Food()
        food.Brand = "Test"
        food.Name = "Food"
        main.foodItemsArray.append(Food())
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testGetJsonFromURL() {
        main.searchBarButton.SearchTextField.text = "Test"
        main.getJsonFromUrl()
        
        XCTAssertEqual("Test", main.searchCriteria)
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
    
    func testReload() {
        main.reload()
        
        XCTAssertEqual(1, main.foodItemsArray.count)
    }
    
    func testBackPressed() {
        main.backButtonPressed()
        
        XCTAssertTrue(parent.popWasCalled)
    }
    
    func testCellReturnedWithItem() {
        let cell = main.tableView(main.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! FoodSearchCell
        
        XCTAssertEqual("", cell.nameLabel.text)
    }
    
    func testCellPressed() {
        main.tableView(main.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
}
