//
//  TimerAbsractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TimerAbstractSVC: TimerStopWatchAbstractSVC {

    override func changeSeconds() {
        seconds -= 1
    }
    
}
