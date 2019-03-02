//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MedicationEditSVC : MedicationModifyAbstractSVC {
    
    var editingMedicationItem : SavedMedicationDBT!{
        didSet {
            selectedName = editingMedicationItem.MedicationName
            selectedStartTime = editingMedicationItem.TimeOfDay
            selectedAmount = editingMedicationItem.MedicationAmount
            selectedRate = editingMedicationItem.Frequency
        }
    }
    
    override func ConfirmPressed() {
        
        if let name = selectedName, let startTime = selectedStartTime, let amount = selectedAmount, let rate =  selectedRate  {

            if rate == "" {
                return
            }
            
            print("Rate: " + rate)
            
            let newItem = SavedMedicationDBT()
            newItem.MedicationName = name
            newItem.TimeOfDay = startTime
            newItem.MedicationAmount = amount
            newItem.MedicationUOM = "pills"
            newItem.Frequency = rate
            
            savedMedications.updateSavedMedicationItem(oldItem: editingMedicationItem, newItem: newItem)
            
            parentVC.updateProgressBar();
            parentVC.resetToDefaultView()
        }
        
    }
    
}
