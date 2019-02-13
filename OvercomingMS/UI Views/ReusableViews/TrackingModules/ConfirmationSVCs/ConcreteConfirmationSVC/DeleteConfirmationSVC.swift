//
//  CancelConfirmationSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class DeleteConfirmationSVC : ConfirmationSVC {
    
    override func customSetup() {
        topDescription.text = "You are about to delete this item from today's achievements"
        bottomDescription.text = "you will not be able to undo this action"
        super.customSetup()
    }
}
