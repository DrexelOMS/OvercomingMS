//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class Omega3EditSVC : Omega3ModifyAbstractSVC {
    
    var editingOmega3Item : Omega3HistoryDBT!{
        didSet {
            selectedType = editingOmega3Item.supplementName
            selectedStartTime = editingOmega3Item.StartTime
            selectedAmount = editingOmega3Item.Amount
        }
    }
    
    override func ConfirmPressed() {
        if let type = selectedType, let startTime = selectedStartTime, let amount = selectedAmount {
            if amount <= 0 {
                return;
            }
                
            let newItem = Omega3HistoryDBT()
            newItem.supplementName = type
            newItem.StartTime = startTime
            newItem.Amount = amount
            
            omega3History.updateOmega3Item(oldItem: editingOmega3Item, newItem: newItem)
            parentVC.updateProgressBar();
            parentVC.popSubView()
        }
    }
    
}

