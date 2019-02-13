//
//  ModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class ModifyAbstractSVC : SlidingAbstractSVC, TypeTFIDelegate, DateTimeTFIDelegate, LengthTFIDelegate {
    func onLengthTFIDone() {
        print(typeTFI.selectedType)
    }
    
    func onTypeTFIDone() {
        print(lengthTFI.selectedLength)
    }
    
    func onDateTimeTFIDone() {
        print(dateTimeTFI.selectedStartTime)
    }
    
    @IBOutlet weak var textInputStackView: UIStackView!
    
    override var nibName: String {
        get {
            return "ModifyAbstractSVC"
        }
    }
    
    var tempSelectedType : String?
    var selectedType : String?
    var selectedStartTime : Date?
    var selectedLength : Int? // In minutes
    
    //TODO: replace with pickers
    var typeTFI = ExerciseTypeTFI()
    var dateTimeTFI = DateTimeTFI()
    var lengthTFI = LengthTFI()
    
    @IBOutlet weak var backConfirmButtons: BackConfirmButtonSVC!
    
    override func customSetup() {
        //set the initial text and start time of the textField
        //selectedStartTime = Date()
        //timeTextField.text = OMSDateAccessor.getDateTime(date: Date())
        
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
    
    //delegate method of onTextFieldDatePickerDone() { textFieldDatePicker.getDate }
    
    override func updateColors() {
        print("remember to update colors")
    }
    
    func BackPressed() {
        parentVC.popSubView()
    }
    
    func ConfirmPressed() {
        fatalError("Override Confirm Pressed")
    }
    
}

class ExerciseModifyAbstractSVC : ModifyAbstractSVC {
    
    let exerciseRoutines = ExerciseHistoryDBS()
    
}
