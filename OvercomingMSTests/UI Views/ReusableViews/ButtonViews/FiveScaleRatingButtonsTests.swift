//
//  FiveScaleRatingButtonsTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class FiveScaleRatingButtonsTests: XCTestCase {
    
    var main: FiveScaleRatingButtonsSVC!
    var dbs: FoodRatingDBS!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        main = FiveScaleRatingButtonsSVC()
        dbs = FoodRatingDBS()
    }
    
    func testReloadRating1() {
        dbs.setRating(amount: 1)
        
        main.reload()
        
        main.rating1.backgroundColor = main.colorTheme
    }
    
    func testReloadRating2() {
        dbs.setRating(amount: 2)
        
        main.reload()
        
        main.rating2.backgroundColor = main.colorTheme
    }
    
    func testReloadRating3() {
        dbs.setRating(amount: 3)
        
        main.reload()
        
        main.rating3.backgroundColor = main.colorTheme
    }
    
    func testReloadRating4() {
        dbs.setRating(amount: 4)
        
        main.reload()
        
        main.rating4.backgroundColor = main.colorTheme
    }
    
    func testReloadRating5() {
        dbs.setRating(amount: 5)
        
        main.reload()
        
        main.rating5.backgroundColor = main.colorTheme
    }
    
    func testRating1Pressed() {
        main.rank1Click(UITapGestureRecognizer())
        
        XCTAssertEqual(1, dbs.getRating())
    }
    
    func testRating2Pressed() {
        main.rank2Click(UITapGestureRecognizer())
        
        XCTAssertEqual(2, dbs.getRating())
    }
    
    func testRating3Pressed() {
        main.rank3Click(UITapGestureRecognizer())
        
        XCTAssertEqual(3, dbs.getRating())
    }
    
    func testRating4Pressed() {
        main.rank4Click(UITapGestureRecognizer())
        
        XCTAssertEqual(4, dbs.getRating())
    }
    
    func testRating5Pressed() {
        main.rank5Click(UITapGestureRecognizer())
        
        XCTAssertEqual(5, dbs.getRating())
    }
    
}
