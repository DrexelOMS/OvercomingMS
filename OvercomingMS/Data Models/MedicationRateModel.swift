//
//  MedicationRateModel.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/25/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation

class MedicationRateModel {
    
    static let options = ["EveryDay", "WeekDays", "WeekEnds", "Custom"]
    
    var dictionary : Dictionary = ["M": false, "T": false, "W": false, "R": false, "F": false, "S": false, "U": false]
    
    private var _rateString = ""
    
    var rateString: String { //MTWRFSU
        get{
            var string = ""
            if !MedicationRateModel.options.contains(_rateString) {
                for key in dictionary.keys {
                    if dictionary[key] ?? false {
                        string += key
                    }
                }
            }
            else {
                string = _rateString
            }
            return string
        }
        set {
            if MedicationRateModel.options.contains(newValue) {
                _rateString = newValue
            }
            else {
                for key in dictionary.keys {
                    dictionary[key] = newValue.contains(key)
                }
            }
        }
    }
    
    convenience init(rateString: String) {
        self.init()
        
        self.rateString = rateString
    }
    
}
