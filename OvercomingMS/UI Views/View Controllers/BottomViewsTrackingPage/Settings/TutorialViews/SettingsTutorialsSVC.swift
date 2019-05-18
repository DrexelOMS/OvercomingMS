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
import Player

class SettingsTutorialsSVC : SlidingAbstractSVC, PlayerDelegate, PlayerPlaybackDelegate {
    
    func playerCurrentTimeDidChange(_ player: Player) {
        
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        backPressed()
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
        
    }
    
    func playerReady(_ player: Player) {
        
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
    
    func player(_ player: Player, didFailWithError error: Error?) {
        
    }
    
    
    override var nibName: String {
        get {
            return "SettingsTutorialsSVC"
        }
    }
    
    convenience init(isOnboarding: Bool) {
        self.init()
        
        self.isOnboarding = isOnboarding
        if isOnboarding {
//            backButton.isContinueButton = true
        }
    }
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    @IBOutlet weak var playerView: UIView!
    
    var player : Player!
    
    private var isOnboarding = false

    override func customSetup() {
//        backButton.backButtonAction = backPressed
    }
    
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
    }
    
    func play(){
        player = Player()
        player.playerDelegate = self
        player.playbackDelegate = self
        
        player.view.frame = playerView.bounds
        parentVC.addChild(player)
        playerView.addSubview(self.player.view)
        player.didMove(toParent: parentVC)
//        player.view.frame = parentVC.view.bounds
//        parentVC.addChild(player)
//        parentVC.view.addSubview(self.player.view)
//        player.didMove(toParent: parentVC)
        
        player.view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backPressed(tapGestureRecognizer: )))
        player.view.addGestureRecognizer(tapGesture)
        
        let videoUrl: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "Tutorial720", ofType:"mov")!)// file or http url
        self.player.url = videoUrl
        
        self.player.playFromBeginning()
    }

    @objc func backPressed(tapGestureRecognizer: UITapGestureRecognizer) {
        player.pause()
//        player.removeFromParent()
//        player.view.removeFromSuperview()
        
        if isOnboarding {
            
            let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to skip the tutorial", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
                self.parentVC.dismiss()
            })
            
            // Create Cancel button with action handlder
            let cancel = UIAlertAction(title: "No", style: .cancel) { (action) -> Void in
                self.player.playFromCurrentTime()
            }
            
            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            // Present dialog message to user
            parentVC.present(dialogMessage, animated: true, completion: nil)
        }
        else {
            parentVC.popSubView()
        }
    
    }
    
    func backPressed() {
        player.pause()

        if isOnboarding {
            parentVC.dismiss()
        }
        else {
            parentVC.popSubView()
        }
    }
    
    
}
