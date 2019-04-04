//
//  ExerciseSelectedItem.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class MedicationSelectedItemSVC : SelectedItemSVC {
    
    var savedMedicationItem : SavedMedicationDBT!
    {
        didSet {
            reload()
        }
    }
    
    override func customSetup() {
        super.customSetup()
        
        topSubLabel.text = "Name"
        middleSubLabel.text = "Time"
        bottomSubLabel.text = "Note"
    }
    
    override func reload() {
        bottomMainLabel.text = "\(savedMedicationItem.MedicationNote)"
        topMainLabel.text = savedMedicationItem.MedicationName
        middleMainLabel.text = OMSDateAccessor.getDateTime(date: savedMedicationItem.TimeOfDay)
        middleFrequencyLabel.isHidden = false
        middleFrequencyLabel.attributedText = MedicationRateModel(rateString: savedMedicationItem.Frequency).attributedString()
    }
    
    override func editButtonPressed() {
        let editPage = MedicationEditSVC()
        editPage.editingMedicationItem = savedMedicationItem
        parentVC.pushSubView(newSubView: editPage)
    }
    
    override func repeatButtonPressed() {
        let repeatPage = RepeatConfirmationSVC(methodToRunOnConfirm: repeatItem, resetToDefault: true)
        parentVC.pushSubView(newSubView: repeatPage)
    }
    
    func repeatItem() {
        SavedMedicationDBS().addMedicationItem(medicationName: savedMedicationItem.MedicationName, timeOfDay: savedMedicationItem.TimeOfDay, medicationNote: savedMedicationItem.MedicationNote, freq: savedMedicationItem.Frequency, active: true)
    }
    
    
    override func deleteButtonPressed() {
        let deletePage = DeleteConfirmationSVC(methodToRunOnConfirm: deleteItem, resetToDefault: true)
        parentVC.pushSubView(newSubView: deletePage)
    }
    
    func deleteItem(){
       SavedMedicationDBS().deleteSavedMedication(item: savedMedicationItem)
    }
}
