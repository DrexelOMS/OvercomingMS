//
//  ExerciseSelectedItem.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class ExerciseSelectedItemSVC : SelectedItemSVC {
    
    var exerciseItem : ExerciseHistoryDBT!
        
    {
        didSet {
            reload()
        }
    }
    
    override func customSetup() {
        super.customSetup()
        
        topSubLabel.text = "Type"
        middleSubLabel.text = "Time"
        bottomSubLabel.text = "Length"
    }
    
    override func updateColors() {
        //Update color themes
    }
    
    override func reload() {
        print(exerciseItem)
        topMainLabel.text = exerciseItem.RoutineType
        middleMainLabel.text = OMSDateAccessor.getDateTime(date: exerciseItem.StartTime)
        bottomMainLabel.text = "\(exerciseItem.minutes) min."
    }
    
    override func editButtonPressed() {
        let editPage = ExerciseEditSVC()
        editPage.editingExerciseItem = exerciseItem
        parentVC.pushSubView(newSubView: editPage)
    }
    
    override func repeatButtonPressed() {
        let repeatPage = RepeatConfirmationSVC(methodToRunOnConfirm: repeatItem, resetToDefault: true)
        parentVC.pushSubView(newSubView: repeatPage)
    }
    
    func repeatItem() {
        let type = exerciseItem.RoutineType
        let startTime = Date()
        let endTime = startTime.addingTimeInterval(TimeInterval(exerciseItem.minutes * 60))
        ExerciseHistoryDBS().addExerciseItem(routineType: type, startTime: startTime, endTime: endTime)
    }
    
    
    override func deleteButtonPressed() {
        let deletePage = DeleteConfirmationSVC(methodToRunOnConfirm: deleteItem, resetToDefault: true)
        parentVC.pushSubView(newSubView: deletePage)
    }
    
    func deleteItem(){
       ExerciseHistoryDBS().deleteExerciseItem(item: exerciseItem)
    }
}
