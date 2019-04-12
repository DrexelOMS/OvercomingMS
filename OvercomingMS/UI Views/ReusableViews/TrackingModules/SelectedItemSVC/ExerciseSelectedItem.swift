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
    
    override func reload() {
        topMainLabel.text = exerciseItem.RoutineType
        middleMainLabel.text = OMSDateAccessor.getDateTime(date: exerciseItem.StartTime)
        bottomMainLabel.text = "\(exerciseItem.minutes) \(ProgressBarConfig.lengthUOM)"
    }
    
    override func editButtonPressed() {
        let editPage = ExerciseModifySVC()
        editPage.editingExerciseItem = exerciseItem
        parentVC.pushSubView(newSubView: editPage)
    }
    
    override func repeatButtonPressed() {
        let repeatPage = ConfirmationFactory.RepeatConfirmation()
        repeatPage.methodToRunOnConfirm = repeatItem
        repeatPage.resetToDefault = true
        parentVC.pushSubView(newSubView: repeatPage)
    }
    
    func repeatItem() {
        let newItem = ExerciseHistoryDBT()
        let startTime = Date()
        
        newItem.RoutineType = exerciseItem.RoutineType
        newItem.StartTime = startTime
        newItem.EndTime = startTime.addingTimeInterval(TimeInterval(exerciseItem.minutes * 60))
        ExerciseHistoryDBS().addItem(item: newItem)
    }
    
    override func deleteButtonPressed() {
        let deletePage = ConfirmationFactory.DeleteConfirmation()
        deletePage.methodToRunOnConfirm = deleteItem
        deletePage.resetToDefault = true
        parentVC.pushSubView(newSubView: deletePage)
    }
    
    func deleteItem(){
       ExerciseHistoryDBS().deleteItem(item: exerciseItem)
    }
}
