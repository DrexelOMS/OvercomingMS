//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ExerciseAddSVC : ModifyAbstractSVC {
    
    override func ConfirmPressed() {
        if let type = typeTextField.text, let minutes = Int(minutesTextField.text ?? "") {
            if minutes <= 0 {
                return;
            }
            
            let startTime = Date()
            let iMinutes = minutes
            let endTime = startTime.addingTimeInterval(TimeInterval(iMinutes * 60))
            exerciseRoutines.addExerciseItem(routineType: type, startTime: startTime, endTime: endTime)
            parentVC.updateProgressBar();
            
            parentVC.popSubView()
        }
    }
    
}
