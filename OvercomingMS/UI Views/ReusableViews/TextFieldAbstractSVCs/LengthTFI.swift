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
            textField.text = "\(selectedLength!) \(ProgressBarConfig.lengthUOM)"
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
        textField.inputView = lengthPicker
    }

    override func doneFunction() {
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
