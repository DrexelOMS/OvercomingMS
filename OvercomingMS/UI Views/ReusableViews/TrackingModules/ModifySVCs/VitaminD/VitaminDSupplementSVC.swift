//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class VitaminDSupplementSVC : VitaminDModifyAbstractSVC {
    
    let defaults = UserDefaults.standard
    
    let VITAMIND_SUPPLEMENT_NAME_UD = "VitaminDSupplementName"
    let VITAMIND_SUPPLEMENT_AMOUNT_UD = "VitaminDSupplementAmount"
    
    override func customSetup() {
        super.customSetup()
        
        if let type = defaults.value(forKey: VITAMIND_SUPPLEMENT_NAME_UD) as? String {
            selectedType = type
        }
        if let amount = defaults.value(forKey: VITAMIND_SUPPLEMENT_AMOUNT_UD) as? Int {
            selectedAmount = amount
        }
    }
    
    override func ConfirmPressed() {
        if let type = selectedType, let startTime = selectedStartTime, let amount = selectedAmount {
            if amount <= 0 {
                return;
            }
            
            saveSupplementQuery(name: type, amount: amount)
            
            vitaminDHistory.addVitaminDItem(vitaminDType: type, startTime: startTime, vitaminDAmount: amount)
            parentVC.reload();
            parentVC.popSubView()
        }
    }
    
    func saveSupplementQuery(name: String, amount: Int) {
        defaults.set(name, forKey: VITAMIND_SUPPLEMENT_NAME_UD)
        defaults.set(amount, forKey: VITAMIND_SUPPLEMENT_AMOUNT_UD)
    }
    
}

