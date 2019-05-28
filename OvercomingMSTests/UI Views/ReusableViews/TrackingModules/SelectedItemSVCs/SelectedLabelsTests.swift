//
//  SelectedLabelsTests.swift
//  OvercomingMSTests
//
//  Created by user150052 on 5/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import XCTest
@testable import OvercomingMS

class SelectedLabelsTests: XCTestCase {
    var a = "Test1"
    var b = "Test2"
    
    
    
    func testLabelSetup()
    {
        let item = SelectedLabelsSVC(mainLabel:"Test1", subLabel:"Test2")
        
        XCTAssertEqual( a , item.mainLabel.text)
        XCTAssertEqual( b , item.subLabel.text) 
    }
}
