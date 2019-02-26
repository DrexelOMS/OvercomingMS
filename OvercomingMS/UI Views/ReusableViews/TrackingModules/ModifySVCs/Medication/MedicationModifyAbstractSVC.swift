//
//  ExerciseModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class MedicationModifyAbstractSVC : ModifyAbstractSVC {
    
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
    var selectedAmount : Int?  { // In minutes
        get {
            return amountTFI.selectedAmount
        }
        set {
            amountTFI.selectedAmount = newValue
        }
    }
    var selectedRate : String? {
        get {
            return rateTFI.selectedType
        }
        set {
            if let string = newValue {
            if !rateTFI.choices.contains(string) {
                rateTFI.rateString = string
                rateTFI.selectedType = "Custom"
            }
            else {
                rateTFI.selectedType = string
            }
            }
        }
    }
    
    var nameTFI = CustomEntryTFI(title: "Name")
    var dateTimeTFI = DateTimeTFI()
    var amountTFI = AmountTFI(uom: "pills")
    var rateTFI = MedicationRateTFI()
    
    override func customSetup() {
        //set the initial text and start time of the textField
        selectedStartTime = Date()
        
        textInputStackView.addArrangedSubview(nameTFI)
        textInputStackView.addArrangedSubview(dateTimeTFI)
        textInputStackView.addArrangedSubview(amountTFI)
        textInputStackView.addArrangedSubview(rateTFI)
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
        
    }
    
    override func initialize(parentVC: TrackingModuleAbstractVC) {
        super.initialize(parentVC: parentVC)
        
    }
    
}
