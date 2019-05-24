//
//  MeditationCountdownSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography
import AVFoundation


class MeditationTimerSVC : TimerStopWatchAbstractSVC {
    
    private var totalTime = 0
    private var type = ""
    var guidedSound = ""
    var player: AVAudioPlayer?

    override var pauseMessage: String {
        get {
            return "Session paused"
        }
    }
    
    override var resumeMessage: String {
        get {
            return "Currently Playing"
        }
    }
    
    override func startPauseButtonPressed() {
        if firstStart
        {
            firstStart = false
            startTime = Date()
            if (type != "Silent"){
                playSound(soundName: guidedSound)
            }
        }
        if isTimerRunning {
            stopTimer()
            if (type != "Silent"){
            pauseSound()
            }
        }
        else {
            resumeTimer()
            if (type != "Silent"){
                resumeSound()
            }
        }
    }
    
    //allow instantiation with start length in seconds
    convenience init(startingSeconds: Int, meditationType: String) {
        self.init()
        seconds = startingSeconds
        totalTime = startingSeconds
        timerLabel.text = timeString(time: Double(seconds))
        type = meditationType
        descriptionLabel.text = "Press Start"

        middleView.removeFromSuperview()
        switch type{
        case "Seed":
            guidedSound = "5_Minute"
            break
        case "Sprout":
            guidedSound = "15_Minute"
            break
        case "Flower":
            guidedSound = "35_Minute"
            break
        case "Tree":
            guidedSound = "45_Minute"
            break
        default:
            type = "Silent"
        }
        let minutes = Int(ceil(Double(totalTime) / 60.0))
        var medType = type
        if medType != "Silent" {
            medType = "Guided"
        }
        SubDescriptionLabel.text = "\(minutes) minutes of \(medType) Meditation"
    }
    
    func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            onDismiss(function: {self.player?.stop()})
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func pauseSound(){
        player?.pause()
    }
    
    func resumeSound(){
        player?.play()
    }
    
    func isDone() -> Bool{
        if(seconds == 0)
        {
            return true
        }
        return false
    }
    override func changeSeconds() {
        if(!isDone()){
            seconds -= 1
        }
    }
    
    override func finishButtonPressed() {
        super.finishButtonPressed()
        pauseSound()
        if(totalTime - seconds > 0)
        {
            let minutes = Int(ceil(Double(totalTime - seconds) / 60.0))
            pushFinishSVC(minutes: minutes)
        }
    }
    
    override func cancelButtonPressed() {
        super.cancelButtonPressed()
        stopTimer()
        pauseSound()
    }

    
    override func pushFinishSVC(minutes: Int) {
        parentVC.pushSubView(newSubView: MeditationModifySVC(type: type, startTime: startTime, length: minutes))
    }
    
    override func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        if hours == 0 {
            if minutes < 10 {
                return String(format:"%01i:%02i", minutes, seconds)
            }
            else {
                return String(format:"%02i:%02i", minutes, seconds)
            }
        }
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
