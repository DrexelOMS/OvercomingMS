//
//  MeditationEditSVC.swift
//  OvercomingMS
//
//  Created by Chris on 3/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationEditSVC: MeditationModifyAbstractSVC {

    var editingMeditationItem : MeditationHistoryDBT!{
        didSet {
            selectedType = editingMeditationItem.RoutineType
            
            selectedStartTime = editingMeditationItem.StartTime
            
            selectedLength = editingMeditationItem.minutes
        }
    }
    
    override func ConfirmPressed() {
        if let type = selectedType, let startTime = selectedStartTime, let minutes = selectedLength {
            if minutes <= 0 {
                return;
            }
            
            let newItem = MeditationHistoryDBT()
            newItem.RoutineType = type
            newItem.StartTime = startTime
            newItem.EndTime = startTime.addingTimeInterval(TimeInterval(minutes * 60))
            
            meditationHistory.updateExerciseItem(oldItem: editingMeditationItem, newItem: newItem)
            
            parentVC.updateProgressBar();
            
            parentVC.popSubView()
        }

    }
}
