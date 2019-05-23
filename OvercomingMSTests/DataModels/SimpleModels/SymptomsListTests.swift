//
//  SymptomsListTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class SymptomsListTests: XCTestCase {
    
    var model: SymptomsList!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        model = SymptomsList()
    }
    
    func testGetSections() {
        SymptomsNoteDBS().addNote(note: "note", symptomsRating: 1, timeOfDay: Date(), dateCreated: "01/01/1996")
        SymptomsNoteDBS().addNote(note: "note1", symptomsRating: 2, timeOfDay: Date(), dateCreated: "01/02/1996")
        
        let list = model.getSections()
        
        XCTAssertEqual("note1", list[0].notes[0].Note)
        XCTAssertEqual("note", list[1].notes[0].Note)
        
    }
}
