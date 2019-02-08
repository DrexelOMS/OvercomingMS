//
//  ModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ModifyAbstractSVC : SlidingAbstractSVC, UITextFieldDelegate {
    
    let exerciseRoutines = ExerciseHistoryDBS()
    
    //TODO: replace with pickers
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var backConfirmButtons: BackConfirmButtonSVC!
    
    
    override var nibName: String {
        get {
            return "ModifyAbstractSVC"
        }
    }
    
    override func customSetup() {
        timeTextField.text = OMSDateAccessor.getDateTime(date: Date())
        
        typeTextField.delegate = self
        timeTextField.delegate = self
        minutesTextField.delegate = self
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
    }
    
    override func updateColors() {
        print("remember to update colors")
    }
    
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        parentVC.view.endEditing(true)
        return false
    }
    
    func BackPressed() {
        parentVC.popSubView()
    }
    
    func ConfirmPressed() {
        fatalError("Override Confirm Pressed")
    }
    
}
