//
//  LengthTFI.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class CustomEntryTFI : TFIAbstract {
    
    var selectedCustomEntry : String? {
        didSet {
            textField.text = "\(selectedCustomEntry!)"
        }
    }
    var savedText = ""
    var title : String {
        get {
            return label.text ?? ""
        }
        set {
            label.text = newValue
        }
    }
    
    convenience init(title: String) {
        self.init()
    
        self.title = title
    }
    
    override func customSetup() {
        super.customSetup()
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
    }
    
    override func cancelFunction() {
        textField.text = savedText
        
        super.cancelFunction()
    }

    
}
