//
//  SettingsMainVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SettingsMainSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "SettingsMainSVC"
        }
    }
    @IBOutlet weak var profileView: RoundedBoxShadowsTemplate!
    @IBOutlet weak var trackingView: SettingsBoxSVC!
    @IBOutlet weak var remindersView: RoundedBoxShadowsTemplate!
    @IBOutlet weak var tutorialsView: RoundedBoxShadowsTemplate!
    
    override func customSetup() {
        profileView.backgroundColor = UIColor.lightGray
        remindersView.backgroundColor = UIColor.lightGray
        tutorialsView.backgroundColor = UIColor.lightGray
        
        trackingView.buttonAction = trackingPressed
    }
    
    func trackingPressed() {
        parentVC.pushSubView(newSubView: SettingsTrackingSVC())
    }
}
