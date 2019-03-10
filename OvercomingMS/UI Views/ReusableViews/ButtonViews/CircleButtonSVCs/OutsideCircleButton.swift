//
//  AddCircleButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/2/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class OutsideCircleButton : CircleButtonSVC {
    
    override func customSetup() {
        //button.setTitle("O", for: .normal)
        buttonImage = UIImage(named: "Outside")
        label.text = "Outside"
    }
}
