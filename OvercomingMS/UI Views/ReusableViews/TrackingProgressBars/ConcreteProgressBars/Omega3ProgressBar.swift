//
//  Omega3ProgressBar.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/16/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class Omega3ProgressBar: TrackingProgressBar, IUpdateProgressBar {
    
    private let omega3History = Omega3HistoryDBS()
    
    func updateProgress() {
        setProgressValue(value: omega3History.getTrackingDay()!.Omega3ComputedPercentageComplete)
        
        var description = ""
        let amountRemaining = ProgressBarConfig.omega3Goal - omega3History.getTotalGrams()
        let uom = ProgressBarConfig.omega3UOM
        if(amountRemaining <= 0 || omega3History.getPercentageComplete() >= 100){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) \(uom) left"
        }
        setRightLabel(description: description)
    }
    
}
