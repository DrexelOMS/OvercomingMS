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
    var savedText = ""
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
        savedText = textField.text ?? ""
        textField.text = ""
    }

    override func doneFunction() {
        if let text = textField.text {
            if text != "" {
                self.selectedCustomEntry = text
            }
            else {
                textField.text = savedText
            }
        }
        else {
            textField.text = savedText
        }
        
        parentVC.view.endEditing(true)
        if self.selectedCustomEntry != nil {
            delegate?.onCustomEntryTFIDone()
        }
    }
    
    override func cancelFunction() {
        textField.text = savedText
        
        super.cancelFunction()
    }

    
}
