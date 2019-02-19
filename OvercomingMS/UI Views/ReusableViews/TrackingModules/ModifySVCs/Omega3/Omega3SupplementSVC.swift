//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class Omega3SupplementSVC : Omega3ModifyAbstractSVC {
    
    let defaults = UserDefaults.standard
    
    let OMEGA3_SUPPLEMENT_NAME_UD = "Omega3SupplementName"
    let OMEGA3_SUPPLEMENT_AMOUNT_UD = "Omega3SupplementAmount"
    
    override func customSetup() {
        super.customSetup()
        
        if let type = defaults.value(forKey: OMEGA3_SUPPLEMENT_NAME_UD) as? String {
            selectedType = type
        }
        if let amount = defaults.value(forKey: OMEGA3_SUPPLEMENT_AMOUNT_UD) as? Int {
            selectedAmount = amount
        }
    }
    
    override func ConfirmPressed() {
        if let type = selectedType, let startTime = selectedStartTime, let amount = selectedAmount {
            if amount <= 0 {
                return;
            }
            
            saveSupplementQuery(name: type, amount: amount)
            
            omega3History.addOmega3Item(supplementName: type, StartTime: startTime, Amount: amount)
            parentVC.updateProgressBar();
            parentVC.popSubView()
        }
    }
    
    func saveSupplementQuery(name: String, amount: Int) {
        defaults.set(name, forKey: OMEGA3_SUPPLEMENT_NAME_UD)
        defaults.set(amount, forKey: OMEGA3_SUPPLEMENT_AMOUNT_UD)
    }
    
}

