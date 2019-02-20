//
//  dateTimeTextFieldInput.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class DateTimeTFI : TFIAbstract {
    
    let datePicker = UIDatePicker()
    var selectedStartTime : Date?
    {
        didSet {
            textField.text =  OMSDateAccessor.getDateTime(date: selectedStartTime!)
        }
    }
    
    override func customSetup() {
        super.customSetup()
        
        label.text = "Start"
        selectedStartTime = Date()
    }
    
    override func showTextFieldInput() {
        //Formate Date
        datePicker.datePickerMode = .time
        datePicker.date = selectedStartTime ?? Date()
        
        textField.inputView = datePicker
    }
    
    override func doneFunction() {
        self.selectedStartTime = datePicker.date
        parentVC.view.endEditing(true)
    }
    
}
