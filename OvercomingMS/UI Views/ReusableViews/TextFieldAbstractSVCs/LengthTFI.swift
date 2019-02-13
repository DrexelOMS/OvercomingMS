//
//  LengthTFI.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol LengthTFIDelegate: class {
    func onLengthTFIDone()
}

class LengthTFI : TFIAbstract {
    
    var delegate : LengthTFIDelegate?
    
    var lengthPicker = UIDatePicker()
    var selectedLength : Int? {
        didSet {
            textField.text = "\(selectedLength!) min."
        }
    }
    
    override func customSetup() {
        super.customSetup()
        label.text = "Length"
    }
    
    override func showTextFieldInput() {
        //Formate Date
        lengthPicker.datePickerMode = .countDownTimer
        lengthPicker.countDownDuration = getTimeInterval(fromMinutes: selectedLength ?? 0)

        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneLengthPicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        textField.inputAccessoryView = toolbar
        textField.inputView = lengthPicker

    }

    @objc func doneLengthPicker(){
        self.selectedLength = getMinutes(fromInterval: lengthPicker.countDownDuration)
        parentVC.view.endEditing(true)
        delegate?.onLengthTFIDone()
    }

    func getMinutes(fromInterval: TimeInterval) -> Int {
        return Int(fromInterval / 60)
    }

    func getTimeInterval(fromMinutes: Int) -> TimeInterval {
        return TimeInterval(fromMinutes * 60)
    }
    
}
