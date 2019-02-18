//
//  LengthTFI.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol VDConversionLengthTFIDelegate: class {
    func onVDConversionLengthTFIDone()
}

class VDConversionLengthTFI : TFIAbstract {
    
    var delegate : VDConversionLengthTFIDelegate?
    
    var lengthPicker = UIDatePicker()
    var selectedLength : Int? {
        didSet {
            textField.text = "\(selectedLength!) \(ProgressBarConfig.lengthUOM)"
            calculatedAmount = ProgressBarConfig.calculateKLUs(minutes: selectedLength!)
        }
    }
    var calculatedAmount : Int? {
        didSet {
            subRightLabel.text = "\(calculatedAmount!) \(ProgressBarConfig.vitaminDUOM)"
        }
    }
    
    override func customSetup() {
        super.customSetup()
        label.text = "Length"
        subLeftLabel.text = "Conversion:"
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
        delegate?.onVDConversionLengthTFIDone()
    }

    func getMinutes(fromInterval: TimeInterval) -> Int {
        return Int(fromInterval / 60)
    }

    func getTimeInterval(fromMinutes: Int) -> TimeInterval {
        return TimeInterval(fromMinutes * 60)
    }
    
}
