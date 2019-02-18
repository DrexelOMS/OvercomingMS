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
        textField.keyboardType = .numberPad
    }

    override func doneFunction(){
        self.selectedAmount = Int(textField.text ?? "0") ?? 0
        parentVC.view.endEditing(true)
        delegate?.onAmountTFIDone()
    }
    
}
