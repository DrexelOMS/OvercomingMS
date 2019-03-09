//
//  MeditationTimerSetupSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationTimerSetupSVC: MeditationTimerSetupAbstractSVC {
    
    override func customSetup() {
        mainLabel.text = "Chose a level:"
        
        level1Button.buttonAction = pushTimerWithLength(_:)
        level2Button.buttonAction = pushTimerWithLength(_:)
        level3Button.buttonAction = pushTimerWithLength(_:)
        level4Button.buttonAction = pushTimerWithLength(_:)
    }
    
}
