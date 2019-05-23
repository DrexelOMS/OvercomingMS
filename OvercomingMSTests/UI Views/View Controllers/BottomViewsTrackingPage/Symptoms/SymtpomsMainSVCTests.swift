//
//  SymtpomsMainSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class SymptomsMainSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: SymptomsMainSVC!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        main = storyboard.instantiateViewController(withIdentifier: "MainTrackingVC") as? MainTrackingVC
//        main.loadView() // This line is the key
        
        main = SymptomsMainSVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
    }
    
    func testTableReturnsCell() {
        SymptomsNoteDBS().addNote(note: "note", symptomsRating: 1, timeOfDay: Date(), dateCreated: "01/01/1996")
        main.reload()
        let cell = main.tableView(main.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! NoteCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual("note", cell.noteSVC.noteLabel.text)
    }
    
    func testTableCellPressed() {
        SymptomsNoteDBS().addNote(note: "note", symptomsRating: 1, timeOfDay: Date(), dateCreated: "01/01/1996")
        main.reload()
        
        main.tableView(main.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is NoteReviewSVC)
    }
    
    func testAddButtonPressed() {
        main.addButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is NoteReviewSVC)
    }
    
    func testListButtonPressed() {
        main.listButtonPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is SymptomsListSVC)
    }
        
}

