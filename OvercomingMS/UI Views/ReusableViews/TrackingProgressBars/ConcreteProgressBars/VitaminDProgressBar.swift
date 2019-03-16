//
//  Omega3ProgressBar.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/16/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class VitaminDProgressBar: TrackingProgressBar, IUpdateProgressBar {
    
    private let vitaminDHistory = VitaminDHistoryDBS()
    
    func updateProgress() {
        setProgressValue(value: vitaminDHistory.getTrackingDay()!.VitaminDComputedPercentageComplete)
        
        var description = ""
        let amountRemaining = ProgressBarConfig.vitaminDGoal - vitaminDHistory.getTotalAmount()
        let uom = ProgressBarConfig.vitaminDUOM
        if(amountRemaining <= 0 || vitaminDHistory.getPercentageComplete() >= 100){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) \(uom) left"
        }
        setRightLabel(description: description)
    }
    
}
