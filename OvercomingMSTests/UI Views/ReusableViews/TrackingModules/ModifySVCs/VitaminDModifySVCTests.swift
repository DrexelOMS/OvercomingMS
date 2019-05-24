//
//  VitaminDModifySVCTests.swift
//  OvercomingMSTests
//
//  Created by Julie Soderstrom on 5/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class VitaminDModifySVCTests: XCTestCase {
    var parent: MockSlidingStackVC!
    var main: VitaminDModifySVC!
    var dbs: VitaminDHistoryDBS!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = VitaminDHistoryDBS()
    }
    
    func testAddItem(){
        main = VitaminDModifySVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedType = "VitaminD_Added"
        main.selectedAmount = 10
        main.selectedStartTime = Date()
        
        main.ConfirmPressed()
        
        let amount = dbs.getTotalAmount()
        
        XCTAssertEqual(10, amount)
    }
    
    func testAddSupplement() {
        main = VitaminDModifySVC()
        main.isSupplementPage = true
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedType = "VitaminD_Added"
        main.selectedAmount = 10
        main.selectedStartTime = Date()
        
        main.ConfirmPressed()
        
        let defaults = UserDefaults.standard
        
        XCTAssertEqual("VitaminD_Added", defaults.string(forKey: main.VITAMIND_SUPPLEMENT_NAME_UD))
        XCTAssertEqual(10, defaults.integer(forKey: main.VITAMIND_SUPPLEMENT_AMOUNT_UD))
        
    }
    
    func testEditItem() {
        let item = VitaminDHistoryDBT()
        item.Amount = 5
        item.VitaminDType = "VitaminD"
        item.StartTime = Date()
        dbs.addItem(item: item)
        
        main = VitaminDModifySVC()
        main.editingVitamindDItem = dbs.getTodaysVitaminDItems()![0]
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.selectedAmount = 20
        
        main.ConfirmPressed()
        
        let amount = dbs.getTotalAmount()
        
        XCTAssertEqual(20, amount)
    }}
