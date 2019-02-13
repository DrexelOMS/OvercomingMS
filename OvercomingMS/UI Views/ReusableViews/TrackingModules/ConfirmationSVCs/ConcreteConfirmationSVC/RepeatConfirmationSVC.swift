//
//  CancelConfirmationSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class RepeatConfirmationSVC : ConfirmationSVC {
    
    override func customSetup() {
        topDescription.text = "You are about to repeat this entry from today's achievements"
        bottomDescription.text = "This new entry will contain all the same data but with the curent time"
        super.customSetup()
    }
}
