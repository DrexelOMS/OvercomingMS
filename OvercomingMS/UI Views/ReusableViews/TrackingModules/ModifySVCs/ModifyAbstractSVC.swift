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
    }
    
    override func updateColors() {
        print("remember to update colors")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        parentVC.view.endEditing(true)
        return false
    }
    
    @IBAction func BackPressed(_ sender: Any) {
        parentVC.popSubView()
    }
    
    @IBAction func ConfirmPressed(_ sender: Any) {

        if let type = typeTextField.text, let minutes = minutesTextField.text {
            let startTime = Date()
            let iMinutes = Int(minutes) ?? 5
            let endTime = startTime.addingTimeInterval(TimeInterval(iMinutes * 60))
            exerciseRoutines.addExerciseItem(routineType: type, startTime: startTime, endTime: endTime)
            parentVC.updateProgressBar();
            
            parentVC.popSubView()
        }
    }
    
}
