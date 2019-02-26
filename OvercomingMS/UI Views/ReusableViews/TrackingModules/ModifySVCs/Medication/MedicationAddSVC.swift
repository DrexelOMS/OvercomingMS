//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MedicationAddSVC : MedicationModifyAbstractSVC {
    
    override func ConfirmPressed() {
        
        if let name = selectedName, let startTime = selectedStartTime, let amount = selectedAmount, let rate = rateTFI.selectedType  {

            var freq = ""
            if rate == "Custom" {
                if(rateTFI.rateString == "") {
                    selectedRate = ""
                    return
                }
                else {
                    freq = rateTFI.rateString
                }
            }
            
            savedMedications.addMedicationItem(medicationName: name, timeOfDay: startTime, medicationAmount: amount, medicationUOM: "pills", freq: freq, active: true)
            
            parentVC.updateProgressBar();
            parentVC.resetToDefaultView()
        }
        
    }
    
}
