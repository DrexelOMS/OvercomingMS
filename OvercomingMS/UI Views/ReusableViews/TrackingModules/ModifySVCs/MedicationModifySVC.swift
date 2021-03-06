//
//  ExerciseModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class MedicationModifySVC : ModifyAbstractSVC {
    
    let savedMedications = SavedMedicationDBS()
    
    var selectedName : String? {
        get {
            return nameTFI.selectedCustomEntry
        }
        set {
            nameTFI.selectedCustomEntry = newValue
        }
    }
    var selectedStartTime : Date? {
        get {
            return dateTimeTFI.selectedStartTime
        }
        set {
            dateTimeTFI.selectedStartTime = newValue
        }
    }
    var selectedNote : String?  { // In minutes
        get {
            return noteTFI.selectedCustomEntry
        }
        set {
            noteTFI.selectedCustomEntry = newValue
        }
    }
    var selectedRate : String? {
        get {
            return rateTFI.rateModel?.rateString
        }
        set {
            if let string = newValue {
                rateTFI.rateModel = MedicationRateModel(rateString: string)
            }
        }
    }
    
    var nameTFI = CustomEntryTFI(title: "Name")
    var dateTimeTFI = DateTimeTFI()
    var noteTFI = CustomEntryTFI(title: "Note")
    var rateTFI = MedicationRateTFI()
    
    var editingMedicationItem : SavedMedicationDBT!{
        didSet {
            selectedName = editingMedicationItem.MedicationName
            selectedStartTime = editingMedicationItem.TimeOfDay
            selectedNote = editingMedicationItem.MedicationNote
            selectedRate = editingMedicationItem.Frequency
            titleLabel.text = "Confirm changes?"
        }
    }
    
    override func customSetup() {
        //set the initial text and start time of the textField
        selectedStartTime = Date()
        titleLabel.text = "Add Medication"
        
        textInputStackView.addArrangedSubview(nameTFI)
        textInputStackView.addArrangedSubview(dateTimeTFI)
        textInputStackView.addArrangedSubview(noteTFI)
        textInputStackView.addArrangedSubview(rateTFI)
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
        
    }
    
    override func ConfirmPressed() {
        
        if let name = selectedName, let startTime = selectedStartTime, let note = selectedNote, let rate = selectedRate  {
            
            if rate == "" {
                return
            }
            
            let newItem = SavedMedicationDBT()
            newItem.MedicationName = name
            newItem.TimeOfDay = startTime
            newItem.MedicationNote = note
            newItem.Frequency = rate
            
            if editingMedicationItem == nil {
                savedMedications.addItem(item: newItem)
            }
            else {
                savedMedications.updateSavedMedicationItem(oldItem: editingMedicationItem, newItem: newItem)
            }
            parentVC.reload();
            parentVC.resetToDefaultView()
        }
        
    }
}
