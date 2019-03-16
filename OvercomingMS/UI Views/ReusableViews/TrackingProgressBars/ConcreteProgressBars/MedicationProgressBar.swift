//
//  Omega3ProgressBar.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/16/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MedicationProgressBar: TrackingProgressBar, IUpdateProgressBar {
    
    private let savedMedications = SavedMedicationDBS()
    
    func updateProgress() {
        setProgressValue(value: savedMedications.getTrackingDay()!.MedicationComputedPercentageComplete)
        
        var description = ""
        let amountRemaining = savedMedications.getTodaysTotalMedGoal() - savedMedications.getTrackingDay()!.MedicationTotal
        let uom = "meds"
        if(amountRemaining <= 0 || savedMedications.getPercentageComplete() >= 100){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) \(uom) left"
        }
        setRightLabel(description: description)
    }
    
}
