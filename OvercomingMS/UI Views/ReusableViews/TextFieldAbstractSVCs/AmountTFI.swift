//
//  LengthTFI.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class AmountTFI : TFIAbstract {
    
    var savedText : String = ""
    var selectedAmount : Int? {
        didSet {
            if isTenK {
                textField.text = "\(selectedAmount!)k \(uom)"
            }
            else {
                textField.text = "\(selectedAmount!) \(uom)"
            }
        }
    }
    var uom: String = ""
    var isTenK: Bool = false
    
    convenience init(uom: String, isTenK: Bool = false) {
        self.init()
        
        self.uom = uom
        self.isTenK = isTenK
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
    }
    
    override func cancelFunction() {
        textField.text = savedText
        
        super.cancelFunction()
    }
    
}
