//
//  Omega3ProgressBar.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/16/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationProgressBar: TrackingProgressBar, IUpdateProgressBar {
    
    private let meditation3History = MeditationHistoryDBS()
    
    func updateProgress() {
        setProgressValue(value: meditation3History.getTrackingDay()!.MeditationComputedPercentageComplete)
        
        var description = ""
        let amountRemaining = ProgressBarConfig.meditationGoal - meditation3History.getTotalMinutes()
        let uom = ProgressBarConfig.lengthUOM
        if(amountRemaining <= 0 || meditation3History.getPercentageComplete() >= 100){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) \(uom) left"
        }
        setRightLabel(description: description)
    }
    
}
