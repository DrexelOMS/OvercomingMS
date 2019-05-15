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
            backButton.isContinueButton = true
        }
    }
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    @IBOutlet weak var playerView: UIView!
    
    var player : Player!
    
    var avPlayer: AVPlayer!
    var playerLayer = AVPlayerLayer()
//    var player = AVPlayer()
    
    private var isOnboarding = false

    override func customSetup() {
        backButton.backButtonAction = backPressed
    }
    
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        player = Player()
        player.playerDelegate = self
        player.playbackDelegate = self
        player.view.frame = playerView.bounds
        
        parentVC.addChild(player)
        playerView.addSubview(self.player.view)
        player.didMove(toParent: parentVC)
        
        let videoUrl: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "TutorialSmall", ofType:"mov")!)// file or http url
        self.player.url = videoUrl
    }
    
    func play(){
//        guard let path = Bundle.main.path(forResource: "Demo_Video", ofType:"mp4") else {
//            debugPrint("video.m4v not found")
//            return
//        }
//        player = AVPlayer(url: URL(fileURLWithPath: path))
//        let playerController = AVPlayerViewController()
//        playerController.player = player
//
//        playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.parentVC.view.bounds
//        parentVC.view.layer.addSublayer(playerLayer)
//        player.play()
        
        self.player.playFromBeginning()
    }
    
    func backPressed() {
//        player.pause()
//        playerLayer.removeFromSuperlayer()
        if isOnboarding {
            parentVC.dismiss()
        }
        else {
            parentVC.popSubView()
        }
    }
    
    
}
