//
//  StopwatchAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class StopwatchAbstractSVC : TimerStopWatchAbstractSVC {
    
    let IMAGEVIEW_WIDTH_CONTRAINT = 65
    let IMAGEVIEW_HEIGHT_CONTRAINT = 65
    
    override func customSetup() {
        super.customSetup()
        
        descriptionLabel.text = "Get Ready To Start."
    }
}
