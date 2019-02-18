//
//  ExerciseModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ExerciseModifyAbstractSVC : ModifyAbstractSVC, TypeTFIDelegate, DateTimeTFIDelegate, LengthTFIDelegate {
    
    let exerciseRoutines = ExerciseHistoryDBS()
    
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
    var selectedLength : Int?  { // In minutes
        get {
            return lengthTFI.selectedLength
        }
        set {
            lengthTFI.selectedLength = newValue
        }
    }
    
    var typeTFI = ExerciseTypeTFI()
    var dateTimeTFI = DateTimeTFI()
    var lengthTFI = LengthTFI()
    
    override func customSetup() {
        //set the initial text and start time of the textField
        selectedStartTime = Date()
        
        textInputStackView.addArrangedSubview(typeTFI)
        textInputStackView.addArrangedSubview(dateTimeTFI)
        textInputStackView.addArrangedSubview(lengthTFI)
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
        
        lengthTFI.delegate = self
        lengthTFI.parentVC = parentVC
    }
    
    func onLengthTFIDone() {
        selectedLength = lengthTFI.selectedLength
    }
    
    func onTypeTFIDone() {
        selectedType = typeTFI.selectedType
    }
    
    func onDateTimeTFIDone() {
        selectedStartTime = dateTimeTFI.selectedStartTime
    }
}