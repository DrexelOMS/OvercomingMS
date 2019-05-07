//
//  SettingsTrackingSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/18/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class WelcomePageSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "WelcomePageSVC"
        }
    }
    
    @IBOutlet weak var continueButton: SquareButtonSVC!

    override func customSetup() {
        continueButton.backButtonAction = backPressed
        
    }
    
    func backPressed() {
        let tutorial = WelcomeTutorialSVC()
        tutorial.parentVC = self.parentVC
        
        parentVC.pushSubView(newSubView: tutorial)
        let deadlineTime = DispatchTime.now() + 0.5 //wait for slide to complete
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            tutorial.play()
        }    }
    
    
}
