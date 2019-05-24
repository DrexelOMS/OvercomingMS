//
//  VitaminDSelectedSVCTests.swift
//  OvercomingMSTests
//
//  Created by Cassandra Li on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import XCTest
@testable import OvercomingMS

class VitaminDSelectedSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: VitaminDSelectedItemSVC!
    var dbs: VitaminDHistoryDBS!
    var item: VitaminDHistoryDBT!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = VitaminDHistoryDBS()
        main = VitaminDSelectedItemSVC()
        
        item = VitaminDHistoryDBT()
        item.VitaminDType = "VitaminD"
        item.StartTime = Date()
        item.Amount = 5
        dbs.addItem(item: item)
        
        main.vitaminDItem = dbs.getTodaysVitaminDItems()![0]
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testDisplaysValues() {
        XCTAssertEqual("VitaminD", main.topMainLabel.text)
        XCTAssertEqual(OMSDateAccessor.getDateTime(date: item.StartTime), main.middleMainLabel.text)
        XCTAssertEqual("5k IUs", main.bottomMainLabel.text)
    }
    
    func testEditButtonPressed() {
        main.editButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        let page = parent.topView as! VitaminDModifySVC
        XCTAssertEqual(5, page.editingVitamindDItem.Amount)
    }
    
    func testRepeatItemPressed() {
        main.repeatButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testRepeatItem() {
        main.repeatItem()
        
        XCTAssertEqual(2, dbs.getTodaysVitaminDItems()!.count)
    }
    
    func testDeleteItemPressed() {
        main.deleteButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testDeleteItem() {
        main.deleteItem()
        
        XCTAssertEqual(0, dbs.getTodaysVitaminDItems()!.count)
    }
    
}
