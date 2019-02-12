//
//  EditCircleButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/8/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class EditCircleButton : CircleButtonSVC {
    
    override func customSetup() {
        //button.setTitle("E", for: .normal)
        buttonImage = UIImage(named: "Edit")
        label.text = "Edit"
    }
}
