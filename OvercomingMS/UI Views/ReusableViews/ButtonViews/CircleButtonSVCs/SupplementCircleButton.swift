//
//  AddCircleButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/2/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SupplementCircleButton : CircleButtonSVC {
    
    override func customSetup() {
        //button.setTitle("S", for: .normal)
        buttonImage = UIImage(named: "Supplement")
        label.text = "Supplement"
    }
}
