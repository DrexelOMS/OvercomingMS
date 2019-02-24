//
//  TypeTextFieldSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MedicationRateTFI : TypeTFIAbstract {
    
    override var choices: [String] {
        get {
            return ["EveryDay", "WeekDays", "WeekEnds", "Custom"]
        }
    }
    
    override var title : String {
        get {
            return "Rate"
        }
    }

    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempSelectedType = choices[row]
        if choices[row] == "Custom" {
            print("show custom")
        }
        else {
            print("hide custom")
        }
    }

}
