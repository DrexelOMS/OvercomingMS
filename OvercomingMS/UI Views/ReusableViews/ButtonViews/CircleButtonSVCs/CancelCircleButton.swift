//
//  TimerCircleButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/2/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class CancelCircleButton : CircleButtonSVC {
    
    override func customSetup() {
        buttonImage = UIImage(named: "Cancel")
        label.text = "Cancel"
    }
}
