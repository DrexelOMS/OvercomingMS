//
//  TimerCircleButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/2/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class StartPauseCircleButton : CircleButtonSVC {
    
    override func customSetup() {
        setStartMode()
    }
    
    func setStartMode() {
        buttonImage = UIImage(named: "Play-Resume")
        label.text = "Start"
    }
    
    func setPauseMode() {
        buttonImage = UIImage(named: "Pause")
        label.text = "Pause"
    }
    
    func setResumeMode() {
        buttonImage = UIImage(named: "Play-Resume")
        label.text = "Resume"
    }
}
