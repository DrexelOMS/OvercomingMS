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
    
    override func customSetup() {
        textField.delegate = self
        textField.inputAccessoryView = getToolBar()
    }
    
    func getInputHeight() -> CGFloat {
        return textField.inputView!.bounds.height + textField.inputAccessoryView!.bounds.height
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showTextFieldInput()
        tfiDelegate?.OnTFIOpened(tfi: self, inputHeight: getInputHeight())
        return true
    }
    
    func showTextFieldInput() {
        fatalError("showtextFieldInput not implemented")
    }
    
    @objc private func donePicker(){
        tfiDelegate?.OnTFIClosed(tfi: self, inputHeight: getInputHeight())
        doneFunction()
    }
    
    func doneFunction() {
        parentVC.view.endEditing(true)
    }
    
    @objc private func cancelPicker(){
        tfiDelegate?.OnTFIClosed(tfi: self, inputHeight: getInputHeight())
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
    
}
