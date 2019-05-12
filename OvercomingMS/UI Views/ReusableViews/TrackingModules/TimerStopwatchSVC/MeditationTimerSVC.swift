//
//  MeditationCountdownSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class MeditationTimerSVC : TimerStopWatchAbstractSVC {
    
    private var totalTime = 0
    private var type = ""
    
    override var pauseMessage: String {
        get {
            return "Session paused"
        }
    }
    
    override var resumeMessage: String {
        get {
            return "Currently Playing"
        }
    }
    
    //allow instantiation with start length in seconds
    convenience init(startingSeconds: Int, meditationType: String) {
        self.init()
        
        seconds = startingSeconds
        totalTime = startingSeconds
        timerLabel.text = timeString(time: Double(seconds))
        type = meditationType
        descriptionLabel.text = "Press Start"
        
        middleView.removeFromSuperview()
        
        let minutes = Int(ceil(Double(totalTime) / 60.0))
        var medType = type
        if medType != "Silent" {
            medType = "Guided"
        }
        SubDescriptionLabel.text = "\(minutes) minutes of \(medType) Meditation"
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
            seconds -= 1
        }
    }
    
    override func finishButtonPressed() {
        super.finishButtonPressed()
        
        if(totalTime - seconds > 0)
        {
            let minutes = Int(ceil(Double(totalTime - seconds) / 60.0))
            pushFinishSVC(minutes: minutes)
        }
    }
    
    
    override func pushFinishSVC(minutes: Int) {
        parentVC.pushSubView(newSubView: MeditationModifySVC(type: type, startTime: startTime, length: minutes))
    }
    
}
