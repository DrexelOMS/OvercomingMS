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

class WelcomeTutorialSVC :  SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "WelcomeTutorialSVC"
        }
    }
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    var avPlayer: AVPlayer!
    var playerLayer = AVPlayerLayer()
    var player = AVPlayer()

    override func customSetup() {

        backButton.backButtonAction = backPressed

    }
    
    func play(){
        guard let path = Bundle.main.path(forResource: "Demo_Video", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.parentVC.view.bounds
        parentVC.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func backPressed() {
        player.pause()
        playerLayer.removeFromSuperlayer()
        parentVC.dismiss()
    }
    
    
}
