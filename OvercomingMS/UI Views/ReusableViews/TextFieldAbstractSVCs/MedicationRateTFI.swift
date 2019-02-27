//
//  TypeTextFieldSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class MedicationRateTFI : TypeTFIAbstract {
    
    override var choices: [String] {
        get {
            return MedicationRateModel.options
        }
    }
    
    let medRate = MedRateButtonsSVC()
    var rateString: String? {
        get {
            if selectedType == "Custom" {
                return medRate.rateModel.rateString
            }
            else {
                return selectedType
            }
        }
        set {
            if MedicationRateModel.options.contains(newValue!) {
                selectedType = newValue
            }
            else {
                selectedType = "Custom"
                medRate.rateModel = MedicationRateModel(rateString: newValue!)
            }
        }
    }
    
    override func customSetup() {
        super.customSetup()
        
        constrain(medRate) { (view) in
            view.height == 100.0
        }
        
        stackView.addArrangedSubview(medRate)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        medRate.isHidden = true
    }
    
    override var title : String {
        get {
            return "Rate"
        }
    }
    
    override func showTextFieldInput() {
        super.showTextFieldInput()

        if tempSelectedType == "Custom" {
            medRate.isHidden = false
        }
    }
    
    override func closePicker() {
        super.closePicker()
        medRate.isHidden = true
        print(rateString)
    }

    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempSelectedType = choices[row]
        if choices[row] == "Custom" {
            medRate.isHidden = false
        }
        else {
            medRate.isHidden = true
        }
    }

}
