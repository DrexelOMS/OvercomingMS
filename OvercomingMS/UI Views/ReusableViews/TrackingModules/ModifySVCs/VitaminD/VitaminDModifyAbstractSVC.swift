//
//  ExerciseModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class VitaminDModifyAbstractSVC : ModifyAbstractSVC {
    
    let vitaminDHistory = VitaminDHistoryDBS()
    
    var selectedType : String? {
        get {
            return vitaminDTypeTFI.selectedType
        }
        set {
            vitaminDTypeTFI.selectedType = newValue
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
    
    var vitaminDTypeTFI = VitaminDTypeTFI()
    var dateTimeTFI = DateTimeTFI()
    var amountTFI = AmountTFI(uom: ProgressBarConfig.vitaminDUOM)
    
    override func customSetup() {
        //set the initial text and start time of the textField
        selectedStartTime = Date()
        
        textInputStackView.addArrangedSubview(vitaminDTypeTFI)
        textInputStackView.addArrangedSubview(dateTimeTFI)
        textInputStackView.addArrangedSubview(amountTFI)
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
        
    }
    
    override func initialize(parentVC: TrackingModuleAbstractVC) {
        super.initialize(parentVC: parentVC)
        
    }
    
}
