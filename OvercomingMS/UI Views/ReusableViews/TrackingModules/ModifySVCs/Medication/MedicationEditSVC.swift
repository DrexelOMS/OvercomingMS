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
            selectedNote = editingMedicationItem.MedicationNote
            selectedRate = editingMedicationItem.Frequency
        }
    }
    
    override func ConfirmPressed() {
        
        if let name = selectedName, let startTime = selectedStartTime, let note = selectedNote, let rate =  selectedRate  {

            if rate == "" {
                return
            }
            
            print("Rate: " + rate)
            
            let newItem = SavedMedicationDBT()
            newItem.MedicationName = name
            newItem.TimeOfDay = startTime
            newItem.MedicationNote = note
            newItem.Frequency = rate
            
            savedMedications.updateSavedMedicationItem(oldItem: editingMedicationItem, newItem: newItem)
            
            parentVC.reload();
            parentVC.resetToDefaultView()
        }
        
    }
    
}
