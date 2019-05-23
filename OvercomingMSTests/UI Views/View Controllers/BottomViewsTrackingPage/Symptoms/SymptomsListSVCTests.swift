//
//  SymptomsListSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class SymptomsListSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: SymptomsListSVC!
    var dbs: SymptomsNoteDBS!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = SymptomsNoteDBS()
        dbs.addNote(note: "note1", symptomsRating: 1, timeOfDay: Date(), dateCreated: "01/02/1996")
        dbs.addNote(note: "note2", symptomsRating: 2, timeOfDay: Date(), dateCreated: "01/01/1996")
        
        main = SymptomsListSVC()
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testHeaders() {
        let header1 = main.tableView(main.tableView, viewForHeaderInSection: 0) as! SymptomsTableHeader
        let header2 = main.tableView(main.tableView, viewForHeaderInSection: 1) as! SymptomsTableHeader
        
        XCTAssertEqual("January 02, 1996", header1.customLabel.text)
        XCTAssertEqual("January 01, 1996", header2.customLabel.text)
    }
    
    func testNotes() {
        let cell1 = main.tableView(main.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! NoteCell
        let cell2 = main.tableView(main.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as! NoteCell
        
        XCTAssertEqual("note1", cell1.noteSVC.noteLabel.text)
        XCTAssertEqual("note2", cell2.noteSVC.noteLabel.text)
    }
    
    func testBackPressed() {
        main.backButtonPressed()
        
        XCTAssertTrue(parent.popWasCalled)
    }
    
    func testSelectedNote() {
        main.tableView(main.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is NoteReviewSVC)
    }
    
    
    
}
