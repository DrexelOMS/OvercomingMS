//
//  MeditationCountdownSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

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
            return "Meditation in progress"
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
    
    override func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        if hours == 0 {
            if minutes < 10 {
                return String(format:"%01i:%02i", minutes, seconds)
            }
            else {
                return String(format:"%02i:%02i", minutes, seconds)
            }
        }
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
