//
//  SavedCircleButtton.swift
//  OvercomingMS
//
//  Created by Corey Hensley on 4/6/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SavedCircleButton : CircleButtonSVC {
    
    override func customSetup() {
        //button.setTitle("D", for: .normal)
        buttonImage = UIImage(named: "Saved")
        label.text = "Saved"
    }
}
