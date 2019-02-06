//
//  BackConfirmButtonSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class BackConfirmButtonSVC : TwoSquareButtonSVC {
    
    override func customSetup() {
        super.customSetup()
        
        LeftButton.setTitle("Back", for: .normal)
        RightButton.setTitle("Confirm", for: .normal)
    }
}
