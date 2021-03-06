//
//  SettingsMainVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class SettingsMainSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "SettingsMainSVC"
        }
    }
    
    @IBOutlet weak var profileView: SettingsBoxSVC!
    @IBOutlet weak var trackingView: SettingsBoxSVC!
    @IBOutlet weak var remindersView: SettingsBoxSVC!
    @IBOutlet weak var tutorialsView: SettingsBoxSVC!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    override func customSetup() {
        profileView.removeFromSuperview()
        remindersView.removeFromSuperview()
        tutorialsView.title = "Tutorials"
        tutorialsView.buttonAction = tutorialsPressed
        tutorialsView.roundedView.backgroundColor = UIColor.white
        
        if globalCurrentDate != OMSDateAccessor().todaysDate {
            trackingView.buttonAction = {}
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
    
    func tutorialsPressed() {

        let tutorial = SettingsTutorialsSVC()
        tutorial.parentVC = self.parentVC

        parentVC.pushSubView(newSubView: tutorial)
        let deadlineTime = DispatchTime.now() + 0.5 //wait for slide to complete
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            tutorial.play()
        }
    }
    
    override func layoutSubviews() {
        DispatchQueue.main.async {
            var rate = 1 - ((896 -  UIScreen.main.bounds.height)) / 328
            rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
            
            let height = 80 + (20) * rate
            
            self.headerHeightConstraint.constant = height
        }
    }
}
