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
        
        if globalCurrentDate != OMSDateAccessor().todaysDate {
            trackingView.buttonAction = presentSwitchDate
            trackingView.roundedView.backgroundColor = UIColor.lightGray
        }
        else {
            trackingView.buttonAction = trackingPressed
            trackingView.roundedView.backgroundColor = UIColor.white
        }
    }
    
    func trackingPressed() {
        parentVC.pushSubView(newSubView: SettingsTrackingSVC())
    }
    
    func presentSwitchDate() {
        print("Switch to todays date")
    }
}
