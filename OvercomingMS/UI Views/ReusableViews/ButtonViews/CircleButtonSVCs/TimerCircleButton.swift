//
//  TimerCircleButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/2/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TimerCircleButton : CircleButtonSVC {
    
    override func customSetup() {
        button.titleLabel?.text = "T"
        label.text = "Timer"
    }
}
