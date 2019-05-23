//
//  Omega3ModifySVC.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class Omega3ModifySVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: Omega3ModifySVC!
    var dbs: Omega3HistoryDBS!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = Omega3HistoryDBS()
    }
    
    func testAddItem() {
        main = Omega3ModifySVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedType = "Omega3_Added"
        main.selectedAmount = 10
        main.selectedStartTime = Date()
        
        main.ConfirmPressed()
        
        let grams = dbs.getTotalGrams()
        
        XCTAssertEqual(10, grams)
    }
    
    func testAddSupplement() {
        main = Omega3ModifySVC()
        main.isSupplementPage = true
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedType = "Omega3_Added"
        main.selectedAmount = 10
        main.selectedStartTime = Date()
        
        main.ConfirmPressed()
        
        let defaults = UserDefaults.standard
        
        XCTAssertEqual("Omega3_Added", defaults.string(forKey: main.OMEGA3_SUPPLEMENT_NAME_UD))
        XCTAssertEqual(10, defaults.integer(forKey: main.OMEGA3_SUPPLEMENT_AMOUNT_UD))
        
    }
    
    func testEditItem() {
        let item = Omega3HistoryDBT()
        item.Amount = 5
        item.supplementName = "Omega3"
        item.StartTime = Date()
        dbs.addItem(item: item)
        
        main = Omega3ModifySVC()
        main.editingOmega3Item = dbs.getTodaysOmega3Items()![0]
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedAmount = 20
        
        main.ConfirmPressed()
        
        let grams = dbs.getTotalGrams()
        
        XCTAssertEqual(20, grams)
    }
    
}

