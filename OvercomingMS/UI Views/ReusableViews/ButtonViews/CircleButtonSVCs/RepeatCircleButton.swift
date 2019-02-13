//
//  RepeatCircleButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/8/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class RepeatCircleButton : CircleButtonSVC {
    
    override func customSetup() {
        //button.setTitle("R", for: .normal)
        buttonImage = UIImage(named: "Repeat")
        label.text = "Repeat"
    }
}
