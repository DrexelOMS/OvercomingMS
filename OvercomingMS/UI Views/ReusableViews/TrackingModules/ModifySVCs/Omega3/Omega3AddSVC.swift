//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class Omega3AddSVC : Omega3ModifyAbstractSVC {
    
    convenience init(startTime: Date, amount: Int)
    {
        self.init()
        
        selectedStartTime = startTime
        selectedAmount = amount
    }
    
    override func ConfirmPressed() {
        
        if let type = selectedType, let startTime = selectedStartTime, let amount = selectedAmount {
            if amount <= 0 {
                return;
            }
            
            omega3History.addOmega3Item(supplementName: type, StartTime: startTime, Amount: amount)
            parentVC.reload();
            parentVC.resetToDefaultView()
        }
        
    }
    
}
