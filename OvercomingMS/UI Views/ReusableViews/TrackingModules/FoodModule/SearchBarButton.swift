//
//  SearchBarButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/14/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SearchBarButton: CustomView, UITextFieldDelegate{
    
    @IBOutlet var viewBox: UIView!
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var SearchTextField: UITextField!
    override var nibName: String {
        get {
            return "SearchBarButton"
        }
    }
    let test = UIView()

    override func customSetup() {
        SearchTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.frame.size.height += 250;
//        self.frame.size.width = 1000;
        test.backgroundColor = DesignConstants.DEFAULT_BACKGROUND_COLOR
        test.frame = CGRect(x: -100, y: 0, width: 500, height: 250)
        self.contentView?.addSubview(test)
        self.contentView?.sendSubviewToBack(test)

        moveTextField(textField, moveDistance: -250, up: true)

    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        //self.frame.size.height -= 250;
        test.removeFromSuperview()
        moveTextField(textField, moveDistance: -250, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        endEditing(true)
        SearchButton.sendActions(for: .touchUpInside)
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.frame = self.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}
