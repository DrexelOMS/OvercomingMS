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
        topDescription.text = "Cancel"
        bottomDescription.text = "Are You Sure"
        super.customSetup()
    }
}
