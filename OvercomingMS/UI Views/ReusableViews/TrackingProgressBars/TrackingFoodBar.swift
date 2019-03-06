//
//  TrackingFoodBar.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TrackingFoodBar: TrackingProgressBar {
    
    override func customSetup() {
        super.customSetup()
        
        linearProgressBar.isHidden = true
    }

}
