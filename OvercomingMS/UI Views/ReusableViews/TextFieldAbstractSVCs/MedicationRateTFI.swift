//
//  TypeTextFieldSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class MedicationRateTFI : TypeTFI {
    
    let medRateButtons = MedRateButtonsSVC()
    var rateModel: MedicationRateModel? {
        get {
            if selectedType == "Custom" {
                return medRateButtons.rateModel
            }
            else if let type = selectedType {
                return MedicationRateModel(rateString: type)
            }
            return nil
        }
        set {
            if newValue!.isEveryDay() {
                selectedType = MedicationRateModel.options[0]
            }
            else
            {
                selectedType = MedicationRateModel.options[MedicationRateModel.options.count - 1]
                medRateButtons.rateModel = newValue!
            }
        }
    }
    
    override func customSetup() {
        super.customSetup()
        
        constrain(medRateButtons) { (view) in
            view.height == 100.0
        }
        
        stackView.addArrangedSubview(medRateButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        medRateButtons.isHidden = true
        
        choices = MedicationRateModel.options
        title = "Rate"
        label.text = title
        tempSelectedType = choices[0]
    }
    
    override func showTextFieldInput() {
        super.showTextFieldInput()

        if tempSelectedType == "Custom" {
            medRateButtons.isHidden = false
        }
    }
    
    override func closePicker() {
        super.closePicker()
        medRateButtons.isHidden = true
    }

    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempSelectedType = choices[row]
        if choices[row] == "Custom" {
            medRateButtons.isHidden = false
        }
        else {
            medRateButtons.isHidden = true
        }
    }

}
