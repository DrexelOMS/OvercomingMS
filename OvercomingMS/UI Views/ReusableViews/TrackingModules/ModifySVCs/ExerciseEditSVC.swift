//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ExerciseEditSVC : ModifyAbstractSVC {
    
    var editingExerciseItem : ExerciseHistoryDBT!{
        didSet {
            typeTextField.text = editingExerciseItem.RoutineType
            timeTextField.text = OMSDateAccessor.getDateTime(date: editingExerciseItem.StartTime)
            minutesTextField.text = "\(editingExerciseItem.minutes)"
        }
    }
    
    override func ConfirmPressed() {
        if let type = typeTextField.text, let minutes = Int(minutesTextField.text ?? "") {
            if minutes <= 0 {
                return;
            }
                
            let newItem = ExerciseHistoryDBT()
            newItem.RoutineType = type
            newItem.StartTime = editingExerciseItem.StartTime
            let iMinutes = minutes
            newItem.EndTime = editingExerciseItem.StartTime.addingTimeInterval(TimeInterval(iMinutes * 60))
            
            exerciseRoutines.updateExerciseItem(oldItem: editingExerciseItem, newItem: newItem)
            
            parentVC.updateProgressBar();
            
            parentVC.popSubView()
        }
    }
}

