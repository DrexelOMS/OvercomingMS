//
//  Omega3ProgressBar.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/16/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ExerciseProgressBar: TrackingProgressBar, IUpdateProgressBar {
    
    private let exerciseHistory = ExerciseHistoryDBS()
    
    func updateProgress() {
        setProgressValue(value: exerciseHistory.getTrackingDay()!.ExerciseComputedPercentageComplete)
        
        var description = ""
        let amountRemaining = ProgressBarConfig.exerciseGoal - exerciseHistory.getTotalMinutes()
        let uom = ProgressBarConfig.lengthUOM
        if(amountRemaining <= 0 || exerciseHistory.getPercentageComplete() >= 100){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) \(uom) left"
        }
        setRightLabel(description: description)
    }
    
}
