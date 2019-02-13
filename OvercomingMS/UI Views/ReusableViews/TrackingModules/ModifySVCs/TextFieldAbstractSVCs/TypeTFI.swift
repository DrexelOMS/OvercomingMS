//
//  TypeTextFieldSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol TypeTFIDelegate : class {
    func onTypeTFIDone()
}

class TypeTFIAbstract : TFIAbstract, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate : TypeTFIDelegate?
    
    var typePicker = UIPickerView()
    
    var tempSelectedType : String?
    var selectedType : String?
    
    var choices : [String] {
        get {
            fatalError("choices not overriden")
        }
    }
    
    override func customSetup() {
        super.customSetup()
        label.text = "Type"
    }
    
    override func showTextFieldInput() {
        //Formate Date
        typePicker.delegate = self
        typePicker.dataSource = self
        if let type = selectedType {
            typePicker.selectRow(choices.firstIndex(of: type) ?? 0, inComponent: 0, animated: false)
        }

        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTypePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        textField.inputAccessoryView = toolbar
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

    @objc func doneTypePicker(){
        if let type = tempSelectedType {
            self.selectedType = type
            textField.text = type
        }
        parentVC.view.endEditing(true)
        delegate?.onTypeTFIDone()
    }
}

class ExerciseTypeTFI : TypeTFIAbstract {
    
    override var choices: [String] {
        get {
            return ["Run", "Lift", "Push Ups"]
        }
    }
    
}
