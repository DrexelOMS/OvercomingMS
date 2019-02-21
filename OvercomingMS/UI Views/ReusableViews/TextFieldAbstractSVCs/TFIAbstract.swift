//
//  TextFieldAbstractsSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol TFIDelegate: class {
    func OnTFIOpened(tfi: TFIAbstract, inputHeight: CGFloat)
    func OnTFIClosed(tfi: TFIAbstract, inputHeight: CGFloat)
}

class TFIAbstract : CustomView, UITextFieldDelegate {
    
    override var nibName: String {
        get {
            return "TFIAbstract"
        }
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var subLeftLabel: UILabel!
    @IBOutlet weak var subRightLabel: UILabel!
    
    var parentVC: TrackingModuleAbstractVC!
    var tfiDelegate: TFIDelegate?
    var active: Bool = false
    
    override func customSetup() {
        textField.delegate = self
        textField.inputAccessoryView = getToolBar()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
        
    }
    
//    func getInputHeight() -> CGFloat {
//        let mainHeight = textField.inputView?.bounds.height ?? 0.0
//        let accessoryHeight = textField.inputAccessoryView?.bounds.height ?? 0.0
////        if mainHeight == 0.0 {
////
////        }
//        return mainHeight + accessoryHeight
//    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showTextFieldInput()
        active = true
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
        cancelFunction()
    }
    
    func cancelFunction() {
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if active {
                tfiDelegate?.OnTFIOpened(tfi: self, inputHeight: keyboardHeight)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if active {
                tfiDelegate?.OnTFIClosed(tfi: self, inputHeight: keyboardHeight)
                active = false
                print(keyboardHeight)
            }
        }
    }
    
}
