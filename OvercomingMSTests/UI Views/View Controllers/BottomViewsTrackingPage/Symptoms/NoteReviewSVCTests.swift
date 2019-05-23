//
//  NoteReviewSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class NoteReviewSVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: NoteReviewSVC!
    var note: SymptomsNoteDBT!
    var dbs: SymptomsNoteDBS!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        dbs = SymptomsNoteDBS()
        dbs.addNote(note: "note", symptomsRating: 1, timeOfDay: Date(), dateCreated: "01/02/1996")
        note = dbs.getTodaysNotes()[0]
        
        main = NoteReviewSVC(noteItem: note)
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testDeletePressed() {
        main.deletePressed()
        
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testDeleteItem() {
        main.deleteItem()
        
        XCTAssertEqual(0, SymptomsNoteDBS().getTodaysNotes().count)
    }
    
    func testBackPressed() {
        main.backPressed()
        
        XCTAssertTrue(parent.popWasCalled)
    }
    
    func testConfirmPressed_with_data() {
        main.noteTextField.text = "note2"
        main.selectedTime = Date()
        main.selectedSeverity = "2"
        
        main.confirmPressed()
        
        XCTAssertEqual("note2", dbs.getTodaysNotes()[0].Note)
    }

    
    func testDidEndEditing() {
        main.noteTextField.text = ""
        main.textViewDidEndEditing(main.noteTextField)
        
        XCTAssertEqual("Tap to edit", main.noteTextField.text)
    }
    
}
