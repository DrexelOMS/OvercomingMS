//
//  TwoSquareButtonSVCs.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class TwoSquareButtonSVC : CustomView {
    
    @IBOutlet weak var LeftButton: UIButton!
    @IBOutlet weak var RightButton: UIButton!
    
    var leftButtonAction : (() -> ())?
    var rightButtonAction : (() -> ())?
    
    override var nibName: String {
        get {
            return "TwoSquareButtonSVC"
        }
    }
    
    override func customSetup() {
        
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        guard let leftButtonAction = leftButtonAction else {
            fatalError("ButtonAction not set")
        }
        leftButtonAction()
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        guard let rightButtonAction = rightButtonAction else {
            fatalError("ButtonAction not set")
        }
        rightButtonAction()
    }
}
