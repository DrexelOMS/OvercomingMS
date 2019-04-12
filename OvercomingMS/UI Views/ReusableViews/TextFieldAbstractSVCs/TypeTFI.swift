//
//  TypeTextFieldSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TypeTFI : TFIAbstract, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var typePicker = UIPickerView()
    
    var tempSelectedType : String?
    var selectedType : String? {
        didSet {
            textField.text = selectedType
        }
    }
    
    var choices : [String] = []
    var title : String = ""
    
    convenience init(choices: [String], title: String) {
        self.init()
        
        self.choices = choices
        self.title = title
        label.text = title
        tempSelectedType = choices[0]
    }
    
    override func customSetup() {
        super.customSetup()
    }
    
    override func showTextFieldInput() {
        //Formate Date
        typePicker.delegate = self
        typePicker.dataSource = self
        if let type = selectedType {
            typePicker.selectRow(choices.firstIndex(of: type) ?? 0, inComponent: 0, animated: false)
            tempSelectedType = choices[choices.firstIndex(of: type) ?? 0]
        }
        textField.inputView = typePicker

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempSelectedType = choices[row]
    }

    override func doneFunction() {
        if let type = tempSelectedType {
            self.selectedType = type
        }
        closePicker()
    }
}

class SeverityTFI: TypeTFI {
    override func customSetup() {
        super.customSetup()
        choices = ["1", "2", "3", "4", "5"]
        title = "Severity"
    }
    
}
