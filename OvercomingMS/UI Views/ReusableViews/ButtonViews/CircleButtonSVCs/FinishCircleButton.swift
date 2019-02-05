//
//  TimerCircleButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/2/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class FinishCircleButton : CircleButtonSVC {
    
    override func customSetup() {
        buttonImage = UIImage(named: "Finish")
        label.text = "Finish"
    }
}
