//
//  SearchBarButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/14/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SearchBarButton: CustomView, UITextFieldDelegate{
    
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var SearchTextField: UITextField!
    override var nibName: String {
        get {
            return "SearchBarButton"
        }
    }
    
    override func customSetup() {
        SearchTextField.delegate = self
    }
    func textFieldShouldReturn(_ SearchTextField: UITextField) -> Bool {
        endEditing(true)
        SearchButton.sendActions(for: .touchUpInside)
        return true
    }
}
