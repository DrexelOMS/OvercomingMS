//
//  LengthTFI.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol AmountTFIDelegate: class {
    func onAmountTFIDone()
}

class AmountTFI : TFIAbstract {
    
    var delegate : AmountTFIDelegate?
    
    var savedText : String = ""
    var selectedAmount : Int? {
        didSet {
            textField.text = "\(selectedAmount!) \(uom)"
        }
    }
    var uom : String = ""
    
    convenience init(uom: String) {
        self.init()
        
        self.uom = uom
    }
    
    override func customSetup() {
        super.customSetup()
        label.text = "Amount"
    }
    
    override func showTextFieldInput() {
        savedText = textField.text ?? ""
        textField.text = ""
        textField.keyboardType = .numberPad
    }

    override func doneFunction(){
        if let text = textField.text {
            if text != "" {
                self.selectedAmount = Int(text) ?? 0
            }
            else {
                textField.text = savedText
            }
        }
        else {
            textField.text = savedText
        }
        
        parentVC.view.endEditing(true)
        if self.selectedAmount != nil {
            delegate?.onAmountTFIDone()
        }
    }
    
    override func cancelFunction() {
        textField.text = savedText
        
        super.cancelFunction()
    }
    
}
