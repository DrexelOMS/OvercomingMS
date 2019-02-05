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
        button.setTitle("T", for: .normal)
        label.text = "Timer"
    }
}