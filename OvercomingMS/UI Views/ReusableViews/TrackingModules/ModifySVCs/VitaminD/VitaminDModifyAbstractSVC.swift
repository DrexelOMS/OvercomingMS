//
//  ExerciseModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class VitaminDModifyAbstractSVC : ModifyAbstractSVC, TypeTFIDelegate, DateTimeTFIDelegate, VDConversionLengthTFIDelegate, AmountTFIDelegate {
    
    let vitaminDHistory = VitaminDHistoryDBS()
    
    enum ModifyMode {case Supplement, Outside}
    var mode : ModifyMode = .Supplement {
        didSet {
            toggleMode()
        }
    }
    
    var selectedType : String? {
        get {
            return vitaminDTypeTFI.selectedType
        }
        set {
            vitaminDTypeTFI.selectedType = newValue
            if vitaminDTypeTFI.IsOutsideMode() {
                mode = .Outside
            }
            else {
                mode = .Supplement
            }
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
    var selectedLength : Int? {
        get {
            return conversionLengthTFI.selectedLength
        }
    }
    
    var vitaminDTypeTFI = VitaminDTypeTFI()
    var dateTimeTFI = DateTimeTFI()
    var amountTFI = AmountTFI()
    var conversionLengthTFI = VDConversionLengthTFI()
    
    override func customSetup() {
        //set the initial text and start time of the textField
        selectedType = vitaminDTypeTFI.outside
        selectedStartTime = Date()
        
        textInputStackView.addArrangedSubview(vitaminDTypeTFI)
        textInputStackView.addArrangedSubview(dateTimeTFI)
        if mode == .Supplement {
            textInputStackView.addArrangedSubview(amountTFI)
        }
        else {
            textInputStackView.addArrangedSubview(conversionLengthTFI)
        }
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
        
    }
    
    override func initialize(parentVC: TrackingModuleAbstractVC) {
        super.initialize(parentVC: parentVC)
        
        vitaminDTypeTFI.delegate = self
        vitaminDTypeTFI.parentVC = parentVC
        
        dateTimeTFI.delegate = self
        dateTimeTFI.parentVC = parentVC
    
        amountTFI.delegate = self
        amountTFI.parentVC = parentVC
        
        conversionLengthTFI.delegate = self
        conversionLengthTFI.parentVC = parentVC
    }
    
    func toggleMode() {
        if mode == .Supplement {
            conversionLengthTFI.removeFromSuperview()
            textInputStackView.addArrangedSubview(amountTFI)
        }
        else {
            amountTFI.removeFromSuperview()
            textInputStackView.addArrangedSubview(conversionLengthTFI)
        }
    }
    
    func onAmountTFIDone() {
        selectedAmount = amountTFI.selectedAmount
    }
    
    func onVDConversionLengthTFIDone() {
        return
    }
    
    func onTypeTFIDone() {
        selectedType = vitaminDTypeTFI.selectedType
    }
    
    func onDateTimeTFIDone() {
        selectedStartTime = dateTimeTFI.selectedStartTime
    }
    
}
