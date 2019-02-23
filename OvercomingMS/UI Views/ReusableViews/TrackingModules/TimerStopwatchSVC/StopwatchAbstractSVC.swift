//
//  StopwatchAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class StopwatchAbstractSVC : TimerStopWatchAbstractSVC {
    
    let IMAGEVIEW_WIDTH_CONTRAINT = 65
    let IMAGEVIEW_HEIGHT_CONTRAINT = 65
    
    override func customSetup() {
        super.customSetup()
        
        timerLabel.text = "00:00:00"
        descriptionLabel.text = "Get Ready To Start."
    }
    
    override func finishButtonPressed() {
        super.finishButtonPressed()
        
        if(seconds <= 0) {
            return
        }
        
        //TODO: make sure to divide seconds by 60 to get the minutes
        let minutes = seconds
        pushFinishSVC(minutes: minutes)
    }
    
    override func changeSeconds() {
        seconds += 1
    }
}
