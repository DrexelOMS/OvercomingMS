//
//  MeditationCountdownSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationCountdownSVC : TimerAbstractSVC {
    
    //allow instantiation with start length in seconds
    convenience init(startingSeconds: Int) {
        self.init()
        
        print("Start timer with \(startingSeconds)")
    }
}
