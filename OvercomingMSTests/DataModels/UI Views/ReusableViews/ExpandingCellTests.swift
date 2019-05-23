//
//  ExpandingCellTests.swift
//  OvercomingMSTests
//
//  Created by user150052 on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import XCTest
@testable import OvercomingMS

class ExpandingCellTests: XCTestCase {
    
    
    func testHideBottomView(){
        let eC = ExpandingCell()
        eC.bottomView = UIView()
        eC.bottomHeight = NSLayoutConstraint()
        eC.hideBottomView()
        XCTAssertTrue(eC.bottomView.isHidden)
        XCTAssertEqual(0, eC.bottomHeight.constant)
    }
    
    func testClearMethod(){
        let eC = ExpandingCell()
        eC.bottomView = UIView()
        eC.middleView = UIView()
        eC.clear()
        XCTAssertFalse(eC.bottomView.isHidden)
        
    }
}
