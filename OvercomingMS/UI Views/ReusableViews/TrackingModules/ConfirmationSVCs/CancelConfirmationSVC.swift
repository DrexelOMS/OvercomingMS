//
//  CancelConfirmationSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class CancelConfirmationSVC : ConfirmationSVC {
    
    override func customSetup() {
        topDescription.text = "Are you sure you want to cancel"
        bottomDescription.text = "All progress made during this session will be lost"
        super.customSetup()
    }
}
