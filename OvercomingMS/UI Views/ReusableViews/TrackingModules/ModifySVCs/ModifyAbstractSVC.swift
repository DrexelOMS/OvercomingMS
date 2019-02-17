//
//  ModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class ModifyAbstractSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "ModifyAbstractSVC"
        }
    }
    
    @IBOutlet weak var textInputStackView: UIStackView!
    
    @IBOutlet weak var backConfirmButtons: BackConfirmButtonsSVC!

    
    override func updateColors() {
        print("remember to update colors")
    }
    
    func BackPressed() {
        parentVC.popSubView()
    }
    
    func ConfirmPressed() {
        fatalError("Override Confirm Pressed")
    }
    
    
}
