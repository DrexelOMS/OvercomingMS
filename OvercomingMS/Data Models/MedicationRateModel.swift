//
//  MedicationRateModel.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/25/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation

class MedicationRateModel {
    
    var rateString: String { //MTWRFSU
        get{
            var string = ""
            if monday { string += "M" }
            if tuesday { string += "T" }
            if wednesday { string += "W" }
            if thursday { string += "R" }
            if friday { string += "F" }
            if saturday { string += "S" }
            if sunday { string += "U" }
            return string
        }
        set {
            monday = newValue.lowercased().contains("m")
            tuesday = newValue.lowercased().contains("t")
            wednesday = newValue.lowercased().contains("w")
            thursday = newValue.lowercased().contains("r")
            friday = newValue.lowercased().contains("f")
            saturday = newValue.lowercased().contains("s")
            sunday = newValue.lowercased().contains("u")
        }
    }
    
    //ReadOnly
    var monday: Bool = false
    var tuesday: Bool = false
    var wednesday: Bool = false
    var thursday: Bool = false
    var friday: Bool = false
    var saturday: Bool = false
    var sunday: Bool = false
    
    convenience init(rateString: String) {
        self.init()
        
        self.rateString = rateString
    }
    
}
