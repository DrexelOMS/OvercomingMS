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
    @IBOutlet weak var profileView: RoundedBoxShadowsTemplate!
    @IBOutlet weak var trackingView: SettingsBoxSVC!
    @IBOutlet weak var remindersView: RoundedBoxShadowsTemplate!
    @IBOutlet weak var tutorialsView: SettingsBoxSVC!
    
    override func customSetup() {
        profileView.backgroundColor = UIColor.lightGray
        remindersView.backgroundColor = UIColor.lightGray
        tutorialsView.title = "Tutorials"
        tutorialsView.buttonAction = tutorialsPressed
        tutorialsView.roundedView.backgroundColor = UIColor.white
        
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
    func tutorialsPressed() {

        guard let path = Bundle.main.path(forResource: "Demo_Video", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.parentVC.view.bounds
        parentVC.view.layer.addSublayer(playerLayer)
        player.play()
        
        //parentVC.pushSubView(newSubView: SettingsTutorialsSVC())
    }
    
    func presentSwitchDate() {
        print("Switch to todays date")
    }
}
