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

class SettingsTutorialsSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "SettingsTutorialsSVC"
        }
    }
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    var avPlayer: AVPlayer!
    
    override func customSetup() {
        //backButton.backButtonAction = backPressed
        
        
    }
    
    func backPressed() {
        parentVC.popSubView()
    }
    
    
}
