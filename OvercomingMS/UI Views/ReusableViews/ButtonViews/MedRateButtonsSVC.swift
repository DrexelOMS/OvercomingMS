//
//  MedRateButtonsSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MedRateButtonsSVC : CustomView {
    
    override var nibName: String {
        get {
            return "MedRateButtonsSVC"
        }
    }
    
    override func customSetup() {
    
    }
    
    @IBAction func mondayButtonPressed(_ sender: ToggleLabelCircleButton) {
        sender.toggle()
    }
    
}
