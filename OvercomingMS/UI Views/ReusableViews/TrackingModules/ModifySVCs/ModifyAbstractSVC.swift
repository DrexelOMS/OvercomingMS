//
//  ModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class ModifyAbstractSVC : SlidingAbstractSVC, UITextFieldDelegate {
    
    override var nibName: String {
        get {
            return "ModifyAbstractSVC"
        }
    }
    
    var choices : [String] {
        get {
            fatalError("Override choices")
        }
    }
    
    var selectedType : String?
    var selectedStartTime : Date?
    var selectedLength : Int? // In minutes
    
    //TODO: replace with pickers
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var backConfirmButtons: BackConfirmButtonSVC!
    
    override func customSetup() {
        timeTextField.text = OMSDateAccessor.getDateTime(date: Date())
        
        typeTextField.delegate = self
        timeTextField.delegate = self
        minutesTextField.delegate = self
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
        
        selectedStartTime = Date()
    }
    
    override func updateColors() {
        print("remember to update colors")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == typeTextField {
            typeTextFieldPressed()
        }
        else if textField == timeTextField {
            timeTextFieldPressed()
        }
        else if textField == minutesTextField {
            minutesTextFieldPressed()
        }
        return false
    }
    
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        parentVC.view.endEditing(true)
        return false
    }
    
    func typeTextFieldPressed() {
        StringPickerPopover(title: "Type", choices: choices)
            .setSelectedRow(0)
            //.setValueChange(action: { _, selected in print("test")})
            .setDoneButton(action: { (popover, selectedRow, selectedString) in
                self.selectedType = selectedString
                self.typeTextField.text = selectedString
            })
            //.setCancelButton(action: { (_,_,_) in print("cance;")})
            .appear(originView: backConfirmButtons, baseViewController: parentVC)
    }
    
    func timeTextFieldPressed() {
        DatePickerPopover(title: "Time")
            .setDateMode(.time)
            .setDoneButton(action: {_, selectedDate in
                self.selectedStartTime = selectedDate
                self.timeTextField.text = OMSDateAccessor.getDateTime(date: selectedDate)
            })
            .appear(originView: backConfirmButtons, baseViewController: parentVC)
    }
    
    func minutesTextFieldPressed() {
         CountdownPickerPopover(title: "Length")
            .setSelectedTimeInterval(TimeInterval())
            .setDoneButton(action: { (popover, timeInterval) in
                self.selectedLength = Int(timeInterval) / 60
                self.minutesTextField.text = String(self.selectedLength!) + " .min"
            })
            .appear(originView: backConfirmButtons, baseViewController: parentVC)
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
    
    override var choices : [String] {
        get {
            return ["Run", "Lift", "Push Ups"]
        }
    }
    
}
