//
//  MeditationAddSVC.swift
//  OvercomingMS
//
//  Created by Chris on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationAddSVC: MeditationModifyAbstractSVC {
        
    convenience init(startTime: Date, length: Int)
    {
        self.init()
        
        selectedStartTime = startTime
        selectedLength = length
    }
    
    override func ConfirmPressed() {
        
        if let type = selectedType, let startTime = selectedStartTime, let minutes = selectedLength {
            if minutes <= 0 {
                return;
            }
            
            let endTime = startTime.addingTimeInterval(TimeInterval(minutes * 60))
            meditationHistory.addMeditationItem(routineType: type, startTime: startTime, endTime: endTime)
            parentVC.reload();
            
            parentVC.resetToDefaultView()
        }
        
    }
    
}
