//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class VitaminDQuickAddSVC : VitaminDModifyAbstractSVC {
    
//    convenience init(startTime: Date, amount: Int)
//    {
//        self.init()
//
//        selectedStartTime = startTime
//    }
    
    override func ConfirmPressed() {
        
        if let type = selectedType, let startTime = selectedStartTime, let amount = selectedAmount {
            if amount <= 0 {
                return;
            }
            
            vitaminDHistory.addVitaminDSupplementItem(vitaminDType: type, startTime: startTime, vitaminDAmount: amount)
            parentVC.updateProgressBar();
            parentVC.resetToDefaultView()
        }

    }
    
}
