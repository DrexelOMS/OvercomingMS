//
//  MeditationCountdownSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationTimerSVC : TimerAbstractSVC {
    
    private var totalTime = 0
    private var type = ""
    
    //allow instantiation with start length in seconds
    convenience init(startingSeconds: Int, meditationType: String) {
        self.init()
        
        seconds = startingSeconds
        totalTime = startingSeconds
        timerLabel.text = timeString(time: Double(seconds))
        type = meditationType
    }
    
    func isDone() -> Bool{
        if(seconds == 0)
        {
            return true
        }
        return false
    }
    
    override func changeSeconds() {
        if(!isDone()){
            super.changeSeconds()
        }
    }
    
    override func finishButtonPressed() {
        super.finishButtonPressed()
        
        if(seconds>0)
        {
            let minutes = Int(ceil(Double(totalTime - seconds) / 60.0))
            pushFinishSVC(minutes: minutes)
        }
        else
        {
            let minutes = Int(ceil(Double(totalTime)/60.0))
            pushFinishSVC(minutes: minutes)
        }
        
    }
    
    
    override func pushFinishSVC(minutes: Int) {
        parentVC.pushSubView(newSubView: MeditationAddSVC(startTime: startTime, length: minutes))
    }
    
}
