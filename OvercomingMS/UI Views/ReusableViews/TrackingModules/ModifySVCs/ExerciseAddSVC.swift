//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ExerciseAddSVC : ExerciseModifyAbstractSVC {
    
    override func ConfirmPressed() {
        
        if let type = selectedType, let startTime = selectedStartTime, let minutes = selectedLength {
            if minutes <= 0 {
                return;
            }
            
            let endTime = startTime.addingTimeInterval(TimeInterval(minutes * 60))
            exerciseRoutines.addExerciseItem(routineType: type, startTime: startTime, endTime: endTime)
            parentVC.updateProgressBar();
            
            parentVC.popSubView()
        }
        
    }
    
}
