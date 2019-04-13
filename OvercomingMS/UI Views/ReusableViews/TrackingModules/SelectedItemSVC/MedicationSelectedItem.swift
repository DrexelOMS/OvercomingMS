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
        
        deleteButton.setEnabled(enabled: globalCurrentDate == OMSDateAccessor().todaysDate)
    }
    
    override func reload() {
        bottomMainLabel.text = "\(savedMedicationItem.MedicationNote)"
        topMainLabel.text = savedMedicationItem.MedicationName
        middleMainLabel.text = OMSDateAccessor.getDateTime(date: savedMedicationItem.TimeOfDay)
        middleFrequencyLabel.isHidden = false
        middleFrequencyLabel.attributedText = MedicationRateModel(rateString: savedMedicationItem.Frequency).attributedString()
    }
    
    override func editButtonPressed() {
        let editPage = MedicationModifySVC()
        editPage.editingMedicationItem = savedMedicationItem
        parentVC.pushSubView(newSubView: editPage)
    }
    
    override func repeatButtonPressed() {
        let repeatPage = ConfirmationFactory.RepeatConfirmation()
        repeatPage.methodToRunOnConfirm = repeatItem
        repeatPage.resetToDefault = true
        parentVC.pushSubView(newSubView: repeatPage)
    }
    
    func repeatItem() {
        let newItem = SavedMedicationDBT()
        newItem.MedicationName = savedMedicationItem.MedicationName
        newItem.TimeOfDay = savedMedicationItem.TimeOfDay
        newItem.DateCreated = Date()
        newItem.MedicationNote = savedMedicationItem.MedicationNote
        newItem.Frequency = savedMedicationItem.Frequency
        SavedMedicationDBS().addItem(item: newItem)
    }
    
    
    override func deleteButtonPressed() {
        if globalCurrentDate == OMSDateAccessor().todaysDate {
            let deletePage = ConfirmationFactory.DeleteConfirmation()
            deletePage.methodToRunOnConfirm = deleteItem
            deletePage.resetToDefault = true
            parentVC.pushSubView(newSubView: deletePage)
        }
    }
    
    func deleteItem(){
       SavedMedicationDBS().deleteItem(item: savedMedicationItem)
    }
}
