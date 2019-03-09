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
        
        level1Button.buttonAction = pushTimerWithLength
        level2Button.buttonAction = pushTimerWithLength
        level3Button.buttonAction = pushTimerWithLength
        level4Button.buttonAction = pushTimerWithLength
    }
    
}
