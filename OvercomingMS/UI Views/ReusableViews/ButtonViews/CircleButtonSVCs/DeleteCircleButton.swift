//
//  DeleteCircleButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/8/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class DeleteCircleButton : CircleButtonSVC {
    
    override func customSetup() {
        button.setTitle("D", for: .normal)
        //buttonImage = UIImage(named: "Add")
        label.text = "Delete"
    }
}
