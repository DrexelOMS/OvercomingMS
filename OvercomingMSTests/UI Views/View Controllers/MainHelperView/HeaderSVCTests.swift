//
//  HeaderSVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class HeaderSVCTests: XCTestCase {
    
    var main: HeaderSVC!
    
    override func setUp() {
        main = HeaderSVC()
    }
    
    func testSetLabelColors_tracking_colored() {
        main.currentMenuItem = .Tracking
        main.setLabelColors(colored: true)
        
        XCTAssertEqual(main.contrastSelectedTextColor, main.trackingLabel.textColor)
        XCTAssertEqual(main.contrastOffTextColor, main.circlesLabel.textColor)
        XCTAssertEqual(main.contrastOffTextColor, main.historyLabel.textColor)
    }
    
    func testSetLabelColors_tracking_not_colored() {
        main.currentMenuItem = .Tracking
        main.setLabelColors(colored: false)
        
        XCTAssertEqual(main.originalSelectedTextColor, main.trackingLabel.textColor)
        XCTAssertEqual(main.originalOffTextColor, main.circlesLabel.textColor)
        XCTAssertEqual(main.originalOffTextColor, main.historyLabel.textColor)
    }
    
    func testSetLabelColors_circles_colored() {
        main.currentMenuItem = .Circles
        main.setLabelColors(colored: true)
        
        XCTAssertEqual(main.contrastOffTextColor, main.trackingLabel.textColor)
        XCTAssertEqual(main.contrastSelectedTextColor, main.circlesLabel.textColor)
        XCTAssertEqual(main.contrastOffTextColor, main.historyLabel.textColor)
    }
    
    func testSetLabelColors_circles_not_colored() {
        main.currentMenuItem = .Circles
        main.setLabelColors(colored: false)
        
        XCTAssertEqual(main.originalOffTextColor, main.trackingLabel.textColor)
        XCTAssertEqual(main.originalSelectedTextColor, main.circlesLabel.textColor)
        XCTAssertEqual(main.originalOffTextColor, main.historyLabel.textColor)
    }
    
    func testSetLabelColors_history_colored() {
        main.currentMenuItem = .History
        main.setLabelColors(colored: true)
        
        XCTAssertEqual(main.contrastOffTextColor, main.trackingLabel.textColor)
        XCTAssertEqual(main.contrastOffTextColor, main.circlesLabel.textColor)
        XCTAssertEqual(main.contrastSelectedTextColor, main.historyLabel.textColor)
    }
    
    func testSetLabelColors_history_not_colored() {
        main.currentMenuItem = .History
        main.setLabelColors(colored: false)
        
        XCTAssertEqual(main.originalOffTextColor, main.trackingLabel.textColor)
        XCTAssertEqual(main.originalOffTextColor, main.circlesLabel.textColor)
        XCTAssertEqual(main.originalSelectedTextColor, main.historyLabel.textColor)
    }
    
    func testDisplayTrackingMessage() {
        main.displayTrackingMessage(colorTheme: UIColor.red, message: "Message")
        
        XCTAssertEqual("Message", main.messageLabel.text)
        XCTAssertEqual(UIColor.red, main.mainView.fillColor)
    }
    
    func testDisplayPreviousDayMessage() {
        main.displayPreviousDateMessage()
        
        XCTAssertEqual("You are editing a past day!", main.messageLabel.text)
        XCTAssertEqual(UIColor.gray, main.mainView.fillColor)
       
    }
    
    func testRestore() {
        main.restore()
        
        XCTAssertEqual(UIColor.white, main.mainView.fillColor)
        XCTAssertFalse(main.daysInARow.isHidden)
        XCTAssertFalse(main.perfectDaysLabel.isHidden)
    }
}
