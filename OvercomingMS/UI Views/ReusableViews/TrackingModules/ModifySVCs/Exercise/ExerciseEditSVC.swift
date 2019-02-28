//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ExerciseEditSVC : ExerciseModifyAbstractSVC {
    
    var editingExerciseItem : ExerciseHistoryDBT!{
        didSet {
            selectedType = editingExerciseItem.RoutineType
            
            selectedStartTime = editingExerciseItem.StartTime
            
            selectedLength = editingExerciseItem.minutes
        }
    }
    
    override func ConfirmPressed() {
        if let type = selectedType, let startTime = selectedStartTime, let minutes = selectedLength {
            if minutes <= 0 {
                return;
            }
                
            let newItem = ExerciseHistoryDBT()
            newItem.RoutineType = type
            newItem.StartTime = startTime
            newItem.EndTime = startTime.addingTimeInterval(TimeInterval(minutes * 60))
            
            exerciseHistory.updateExerciseItem(oldItem: editingExerciseItem, newItem: newItem)
            
            parentVC.updateProgressBar();
            
            parentVC.popSubView()
        }
    }
    
}

