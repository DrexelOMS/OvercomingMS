//
//  TrackingModuleProgressBar.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TrackingModuleProgressBar : TrackingProgressBar {
    
    override func customSetup() {
        super.customSetup()
        
        self.rightContainerView.isHidden = true
        roundedView.hasShadow = false
    }
}
