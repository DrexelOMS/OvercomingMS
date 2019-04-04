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
        
        if let name = selectedName, let startTime = selectedStartTime, let note = selectedNote, let rate = selectedRate  {
            
            if rate == "" {
                return
            }
            
            print("Rate: " + rate)
            
            savedMedications.addMedicationItem(medicationName: name, timeOfDay: startTime, medicationNote: note, freq: rate, active: true)
            
            parentVC.reload();
            parentVC.resetToDefaultView()
        }
        
    }
    
}
