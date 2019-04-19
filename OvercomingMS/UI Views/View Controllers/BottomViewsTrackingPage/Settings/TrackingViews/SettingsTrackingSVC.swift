//
//  SettingsTrackingSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/18/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SettingsTrackingSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "SettingsTrackingSVC"
        }
    }
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    override func customSetup() {
        backButton.backButtonAction = backPressed
    }
    
    func backPressed() {
        parentVC.popSubView()
    }
}
