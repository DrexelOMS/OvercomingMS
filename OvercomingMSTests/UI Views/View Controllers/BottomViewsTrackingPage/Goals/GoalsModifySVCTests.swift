//
//  GoalsModifySVCTests.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import XCTest
@testable import OvercomingMS

class GoalsModifySVCTests: XCTestCase {
    
    var parent: MockSlidingStackVC!
    var main: GoalsModifySVC!
    
    override func setUp() {
        //Only use these lines if you need to reset the database between tests
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        
        main = GoalsModifySVC()
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
    }
    
    func testBackPressed() {
        main.backPressed()
        
        XCTAssertTrue(parent.pushWasCalled)
        XCTAssertTrue(parent.topView is ConfirmationSVC)
    }
    
    func testConfirmPressed_Food() {
        main.Module = .Food
        main.currentPage = 1
        
        main.confirmPressed()
        
        XCTAssertEqual(2, ProgressBarConfig.foodRatingGoal)
    }
    
    func testConfirmPressed_Omega3() {
        main.Module = .Omega3
        main.currentPage = 10
        
        main.confirmPressed()
        
        XCTAssertEqual(11, ProgressBarConfig.omega3Goal)
    }
    
    func testConfirmPressed_VitaminD() {
        main.Module = .VitaminD
        main.currentPage = 19
        
        main.confirmPressed()
        
        XCTAssertEqual(20, ProgressBarConfig.vitaminDGoal)
    }
    
    func testConfirmPressed_Exercise() {
        main.Module = .Exercise
        main.currentPage = 15
        
        main.confirmPressed()
        
        XCTAssertEqual(16, ProgressBarConfig.exerciseGoal)
    }
    
    func testConfirmPressed_Meditation() {
        main.Module = .Meditation
        main.currentPage = 99
        
        main.confirmPressed()
        
        XCTAssertEqual(100, ProgressBarConfig.meditationGoal)
    }
    
    func testPickerCell_number_label() {
        main.Module = .Exercise
        let cell = main.collectionView(main.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! GoalsPickerCell
        
        XCTAssertEqual("1", cell.label.text)
    }
    
    func testPickerCell_image_set() {
        main = GoalsModifyFactory.FoodGoalsModifySVC()
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.Module = .Food
        let cell = main.collectionView(main.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! GoalsPickerCell
        
        XCTAssertEqual(UIImage(named: "Sad"), cell.imageView.image)
    }
    
    func testScrollDidEndDecelerating() {
        main.scrollViewDidEndDecelerating(UIScrollView())
        
        XCTAssertEqual("1", main.currentGoalLabel.text)
    }
    
    func testScrollDidEndDecelerating_Food() {
        
        main = GoalsModifyFactory.FoodGoalsModifySVC()
        
        parent = MockSlidingStackVC(initialView: main)
        parent.viewDidLoad()
        
        main.Module = .Food

        main.scrollViewDidEndDecelerating(UIScrollView())
        
        XCTAssertEqual("Not great.", main.goalUnitLabel.text)
    }
    
}
