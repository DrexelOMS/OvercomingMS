//
//  LengthTFI.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol CustomEntryTFIDelegate: class {
    func onCustomEntryTFIDone()
}

class CustomEntryTFI : TFIAbstract {
    
    var delegate : CustomEntryTFIDelegate?
    
    var selectedCustomEntry : String? {
        didSet {
            textField.text = "\(selectedCustomEntry!)"
        }
    }
    var title : String = "Default"
    
    convenience init(title: String) {
        self.init()
        
        self.title = title
    }
    
    override func customSetup() {
        super.customSetup()
        label.text = title
    }
    
    override func showTextFieldInput() {
        textField.text = ""
    }

    override func doneFunction() {
        self.selectedCustomEntry = textField.text ?? ""
        parentVC.view.endEditing(true)
        delegate?.onCustomEntryTFIDone()
    }
    
}
