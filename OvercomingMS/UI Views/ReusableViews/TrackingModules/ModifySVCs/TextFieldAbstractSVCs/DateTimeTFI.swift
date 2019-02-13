//
//  dateTimeTextFieldInput.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol DateTimeTFIDelegate: class {
    func onDateTimeTFIDone()
}

class DateTimeTFI : TFIAbstract {
    
    var delegate : DateTimeTFIDelegate?
    
    let datePicker = UIDatePicker()
    var selectedStartTime : Date?
    
    override func customSetup() {
        super.customSetup()
        
        label.text = "Start"
    }
    
    override func showTextFieldInput() {
        //Formate Date
        datePicker.datePickerMode = .time
        datePicker.date = selectedStartTime ?? Date()
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }
    
    @objc func doneDatePicker(){
        self.selectedStartTime = datePicker.date
        textField.text = OMSDateAccessor.getDateTime(date: datePicker.date)
        parentVC.view.endEditing(true)
        delegate?.onDateTimeTFIDone()
    }
    
}
