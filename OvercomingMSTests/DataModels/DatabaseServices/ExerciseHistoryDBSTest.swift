//
//  ExerciseHistoryDBSTest.swift
//  OvercomingMSTests
//
//  Created by Cassandra Li on 5/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

//import Foundation
import XCTest
import RealmSwift
@testable import OvercomingMS

class ExerciseHistoryDBSTests: XCTestCase {
    
    var service: ExerciseHistoryDBS!
    var trackingmods: TrackingModulesDBS!
    var date = "01/01/1996"
    override func setUp() {
        //Make sure this runs first
        cleanAllData()
        AppDelegate().firstTimeInitializers()
        service = ExerciseHistoryDBS(editingDate: date)
        trackingmods = TrackingModulesDBS(editingDate: date)
   
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testAddQuickCompleteItem(){
        service.addQuickCompleteItem()
        let list = service.getTodaysExerciseItems()
        XCTAssertEqual(list?.count ?? 0 , 1)
        XCTAssertEqual(list?[0].RoutineType , "Quick Complete")
    }
    
    func testAddItem(){
        let newItem = ExerciseHistoryDBT()
        newItem.RoutineType = "Running"
        newItem.StartTime = globalCurrentFullDate
        newItem.EndTime = globalCurrentFullDate.addingTimeInterval(60*30)
        service.addItem(item: newItem)
        let list = service.getTodaysExerciseItems()
        XCTAssertEqual(list?.count ?? 0 , 1)
        XCTAssertEqual(list?[0].RoutineType , "Running")
    }
    
    
    func testgetTodaysExerciseItems() {
        let list = service.getTodaysExerciseItems()
        XCTAssertEqual(list?.count, 0)
    }
    
    func testgetTodaysExerciseItems_1Item() {
        service.addQuickCompleteItem()
        let list = service.getTodaysExerciseItems()
        XCTAssertEqual(list?.count ?? 0 , 1)
        
    }
    
    func testgetTotalMinutes() {
        let newItem = ExerciseHistoryDBT()
        newItem.RoutineType = "Running"
        newItem.StartTime = globalCurrentFullDate
        newItem.EndTime = globalCurrentFullDate.addingTimeInterval(60*30)
        service.addItem(item: newItem)
        
        let totalmins = service.getTotalMinutes()
        XCTAssertEqual(totalmins, 30)
    }
    
    func testgetPercentageComplete() {
        let iscomplete = service.getPercentageComplete()
        XCTAssertEqual(iscomplete, 0)
    }
    
    
    
   
    
    func testUpdateExerciseItem() {
        let oldItem = ExerciseHistoryDBT()
        oldItem.RoutineType = "Swimming"
        oldItem.StartTime = globalCurrentFullDate
        oldItem.EndTime = globalCurrentFullDate.addingTimeInterval(60*30)
        
        service.addItem(item: oldItem)
        let list = service.getTodaysExerciseItems()
        XCTAssertEqual(list?[0].RoutineType , "Swimming")

        let newItem = ExerciseHistoryDBT()
        newItem.RoutineType = "Running"
        newItem.StartTime = oldItem.StartTime
        newItem.EndTime = oldItem.EndTime
        
        service.updateExerciseItem(oldItem: oldItem, newItem: newItem)
 
        XCTAssertEqual(oldItem.RoutineType , "Running")

        
    }
    
}
