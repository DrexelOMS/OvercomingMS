//
//  MeditationCountdownSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationTimerSVC : TimerAbstractSVC {
    
    //allow instantiation with start length in seconds
    convenience init(startingSeconds: Int, meditationType: String) {
        self.init()
        
        print("Start \(meditationType) timer with \(startingSeconds)")
    }
}
