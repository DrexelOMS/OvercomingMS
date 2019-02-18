//
//  ExerciseAddSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class VitaminDEditSVC : VitaminDModifyAbstractSVC {
    
    var editingVitamindDItem: VitaminDHistoryDBT! {
        didSet {
            selectedType = editingVitamindDItem.VitaminDType
            selectedStartTime = editingVitamindDItem.StartTime
            selectedAmount = editingVitamindDItem.Amount
            selectedLength = editingVitamindDItem.minutes
        }
    }
    
    override func ConfirmPressed() {
        
        if mode == .Supplement {
            if let type = selectedType, let startTime = selectedStartTime, let amount = selectedAmount {
                if amount <= 0 {
                    return;
                }
                
                let newItem = VitaminDHistoryDBT()
                newItem.IsOutsideType = false
                newItem.VitaminDType = type
                newItem.StartTime = startTime
                newItem.Amount = amount
                
                vitaminDHistory.updateVitaminDItem(oldItem: editingVitamindDItem, newItem: newItem)
                parentVC.updateProgressBar();
                parentVC.resetToDefaultView()
            }
        }
        else {
            if let type = selectedType, let startTime = selectedStartTime, let minutes = selectedLength {
                if minutes <= 0 {
                    return;
                }
                
                let newItem = VitaminDHistoryDBT()
                newItem.IsOutsideType = true
                newItem.VitaminDType = type
                newItem.StartTime = startTime
                let endTime = startTime.addingTimeInterval(TimeInterval(minutes * 60))
                newItem.EndTime = endTime
                
                vitaminDHistory.updateVitaminDItem(oldItem: editingVitamindDItem, newItem: newItem)
                parentVC.updateProgressBar();
                parentVC.resetToDefaultView()
            }
        }

    }
    
}
