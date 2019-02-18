//
//  ExerciseModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class Omega3ModifyAbstractSVC : ModifyAbstractSVC, TypeTFIDelegate, DateTimeTFIDelegate, AmountTFIDelegate {
    
    let omega3History = Omega3HistoryDBS()
    
    var selectedType : String? {
        get {
            return typeTFI.selectedType
        }
        set {
            typeTFI.selectedType = newValue
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
    
    var typeTFI = Omega3TypeTFI()
    var dateTimeTFI = DateTimeTFI()
    var amountTFI = AmountTFI(uom: ProgressBarConfig.omega3UOM)
    
    override func customSetup() {
        //set the initial text and start time of the textField
        selectedStartTime = Date()
        
        textInputStackView.addArrangedSubview(typeTFI)
        textInputStackView.addArrangedSubview(dateTimeTFI)
        textInputStackView.addArrangedSubview(amountTFI)
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
        
    }
    
    override func initialize(parentVC: TrackingModuleAbstractVC) {
        super.initialize(parentVC: parentVC)
        
        typeTFI.delegate = self
        typeTFI.parentVC = parentVC
        
        dateTimeTFI.delegate = self
        dateTimeTFI.parentVC = parentVC
        
        amountTFI.delegate = self
        amountTFI.parentVC = parentVC
    }
    
    func onAmountTFIDone() {
        selectedAmount = amountTFI.selectedAmount
    }
    
    func onTypeTFIDone() {
        selectedType = typeTFI.selectedType
    }
    
    func onDateTimeTFIDone() {
        selectedStartTime = dateTimeTFI.selectedStartTime
    }
}
