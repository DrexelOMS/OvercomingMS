//
//  TypeTextFieldSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TypeTFIAbstract : TFIAbstract, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var typePicker = UIPickerView()
    
    var tempSelectedType : String?
    var selectedType : String? {
        didSet {
            textField.text = selectedType
        }
    }
    
    var choices : [String] {
        get {
            fatalError("choices not overriden")
        }
    }
    
    var title : String {
        get {
            return "Type"
        }
    }
    
    override func customSetup() {
        super.customSetup()
        label.text = title
        tempSelectedType = choices[0]
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
        parentVC.view.endEditing(true)
    }
}

class ExerciseTypeTFI : TypeTFIAbstract {
    
    override var choices: [String] {
        get {
            return ["Run", "Lift", "Push Ups"]
        }
    }
    
}

class Omega3TypeTFI : TypeTFIAbstract {
    
    override var title: String {
        get {
            return "Name"
        }
    }
    
    override var choices: [String] {
        get {
            return ["Flaxseed Oil", "Supplement"]
        }
    }
    
}

class VitaminDTypeTFI : TypeTFIAbstract {
    
    override var choices: [String] {
        get {
            return ["Vitamin", "Other"]
        }
    }
    
}
