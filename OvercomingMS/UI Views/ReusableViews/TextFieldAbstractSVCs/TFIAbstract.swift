//
//  TextFieldAbstractsSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TFIAbstract : CustomView, UITextFieldDelegate {
    
    override var nibName: String {
        get {
            return "TFIAbstract"
        }
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var parentVC : TrackingModuleAbstractVC!
    
    override func customSetup() {
        textField.delegate = self
        textField.inputAccessoryView = getToolBar()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showTextFieldInput()
        return true
    }
    
    func showTextFieldInput() {
        fatalError("showtextFieldInput not implemented")
    }
    
    @objc private func donePicker(){
        doneFunction()
    }
    
    func doneFunction() {
        parentVC.view.endEditing(true)
    }
    
    @objc private func cancelPicker(){
        parentVC.view.endEditing(true)
    }
    
    private func getToolBar() -> UIToolbar{
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        return toolbar
    }
    
}
