//
//  MedicationRateModel.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/25/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

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
    
    func attributedString() -> NSAttributedString {
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor.lightGray];
        let myString = NSMutableAttributedString(string: "SMTWRFS", attributes: attributedStringColor)
        
        var myRange = NSRange(location: 0, length: 1)
        
        if dictionary["U"] ?? false {
            myRange = NSRange(location: 0, length: 1)
            myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: myRange)
        }
        if dictionary["M"] ?? false {
            myRange = NSRange(location: 1, length: 1)
            myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: myRange)
        }
        if dictionary["T"] ?? false {
            myRange = NSRange(location: 2, length: 1)
            myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: myRange)
        }
        if dictionary["W"] ?? false {
            myRange = NSRange(location: 3, length: 1)
            myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: myRange)
        }
        if dictionary["R"] ?? false {
            myRange = NSRange(location: 4, length: 1)
            myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: myRange)
        }
        if dictionary["F"] ?? false {
            myRange = NSRange(location: 5, length: 1)
            myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: myRange)
        }
        if dictionary["S"] ?? false {
            myRange = NSRange(location: 6, length: 1)
            myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: myRange)
        }
        
        let kerning = 3
        let range = NSMakeRange(0, myString.length)
        myString.addAttribute(NSAttributedString.Key.kern, value: NSNumber(value: kerning), range: range)
        return myString
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
