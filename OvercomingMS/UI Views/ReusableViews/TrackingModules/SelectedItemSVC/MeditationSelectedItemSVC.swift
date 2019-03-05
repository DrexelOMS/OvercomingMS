//
//  MeditationSelectedItemSVC.swift
//  OvercomingMS
//
//  Created by Chris on 3/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationSelectedItemSVC: UIView {

    var meditationItem : MeditationHistoryDBT!
        
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
        topMainLabel.text = meditationItem.RoutineType
        middleMainLabel.text = OMSDateAccessor.getDateTime(date: meditationItem.StartTime)
        bottomMainLabel.text = "\(meditationItem.minutes) \(ProgressBarConfig.lengthUOM)"
    }
    
    override func editButtonPressed() {
        let editPage = Meditation()
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
