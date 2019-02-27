//
//  MedicationRateModel.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/25/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation

class MedicationRateModel {
    
    static let options = ["EveryDay", "Custom"]
    
    var dictionary : Dictionary = ["M": false, "T": false, "W": false, "R": false, "F": false, "S": false, "U": false]
    
    var rateString: String { //MTWRFSU
        get{
            var string = ""
            
            for key in dictionary.keys {
                if dictionary[key] ?? false {
                    string += key
                }
            }

            return string
        }
        set {
            for key in dictionary.keys {
                dictionary[key] = newValue.contains(key) || newValue == "EveryDay"
            }
        }
    }
    
    func isEveryDay() -> Bool {
        for pair in dictionary {
            if !pair.value {
                return false
            }
        }
        return true
    }
    
    func formattedString() -> String {
        var string = ""
        var count = 0
        
        if dictionary["U"] ?? false {
            string += "S"
            count += 1
        }
        if dictionary["M"] ?? false {
            string += "M"
            count += 1
        }
        if dictionary["T"] ?? false {
            string += "T"
            count += 1
        }
        if dictionary["W"] ?? false {
            string += "W"
            count += 1
        }
        if dictionary["R"] ?? false {
            string += "R"
            count += 1
        }
        if dictionary["F"] ?? false {
            string += "F"
            count += 1
        }
        if dictionary["S"] ?? false {
            string += "S"
            count += 1
        }
        
        if count >= 7 {
            return MedicationRateModel.options[0]
        }
        
        return string
    }
    
    convenience init(rateString: String) {
        self.init()
        self.rateString = rateString
    }
    
}
