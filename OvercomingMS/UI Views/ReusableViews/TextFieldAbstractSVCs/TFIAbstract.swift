//
//  TextFieldAbstractsSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol TFIDelegate: class {
    func OnTFIOpened(tfi: TFIAbstract, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions, keyboardHeight: CGFloat)
    func OnTFIClosed(tfi: TFIAbstract, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions, keyboardHeight: CGFloat)
}

class TFIAbstract : CustomView, UITextFieldDelegate, ToolBarDelegate {
    
    override var nibName: String {
        get {
            return "TFIAbstract"
        }
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dataEntryView: UIView!
    
    var parentVC: SlidingStackVC!
    var tfiDelegate: TFIDelegate?
    let toolbar = ToolBar()
    var active: Bool = false
    
    override func customSetup() {
        textField.delegate = self
        toolbar.delegate = self
        textField.inputAccessoryView = toolbar.getToolBar()
        
        dataEntryView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapGestureRecognizer: )))
        dataEntryView.addGestureRecognizer(tapGesture)
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func viewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showTextFieldInput()
        active = true
        return true
    }
    
    func showTextFieldInput() {
        fatalError("showtextFieldInput not implemented")
    }
    
    internal func donePressed(){
        doneFunction()
    }
    
    func doneFunction() {
        closePicker()
    }
    
    internal func cancelPressed(){
        cancelFunction()
    }
    
    func cancelFunction() {
        closePicker()
    }
    
    func closePicker() {
        parentVC.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if active {
            let userInfo = notification.userInfo
            
            var animationDuration: TimeInterval = 0.0
            var animationOptions: UIView.AnimationOptions = []
            
            if let animationDurationFromUserInfo = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
                animationDuration = animationDurationFromUserInfo
            }
            
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                
                animationOptions.update(with: .layoutSubviews)
                
                tfiDelegate?.OnTFIOpened(tfi: self, animationDuration: animationDuration, animationOptions: animationOptions, keyboardHeight: keyboardHeight)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if active {
            let userInfo = notification.userInfo
            
            var animationDuration: TimeInterval = 0.0
            var animationOptions: UIView.AnimationOptions = []
            
            if let animationDurationFromUserInfo = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
                animationDuration = animationDurationFromUserInfo
            }
            
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                
                animationOptions.update(with: .layoutSubviews)
                
                tfiDelegate?.OnTFIClosed(tfi: self, animationDuration: animationDuration, animationOptions: animationOptions, keyboardHeight: keyboardHeight)
                active = false
            }
        }
    }
    
    var loadedOnce = false
    
    override func layoutSubviews() {
        if !loadedOnce {
            loadedOnce = true
            DispatchQueue.main.async {
                
                var height = self.frame.height
                if height < 70 {
                    height = 70
                }
                else if height > 150 {
                    height = 150
                }
                
                var rate = 1 - (150 - height) / 80
                rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
                
                let fontSize = 24 + (6) * rate
                
                self.label.font = UIFont(name: self.label.font.fontName, size: fontSize)
                self.textField.font = UIFont(name: self.textField.font!.fontName, size: fontSize)
            }
        }
    }
}
