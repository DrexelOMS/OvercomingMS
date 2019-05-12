//
//  TimerStopWatchAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TimerStopWatchAbstractSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "TimerStopWatchSVC"
        }
    }
    
    var pauseMessage: String {
        get {
            return "Workout paused."
        }
    }
    
    var resumeMessage: String {
        get {
            return "Keep going!"
        }
    }
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var SubDescriptionLabel: UILabel!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    @IBOutlet weak var timerHeight: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    let cancelButton = CircleButtonFactory.CancelButton()
    let startPauseButton = StartPauseCircleButton()
    let finishButton = CircleButtonFactory.FinishButton()
    
    var seconds = 0
    var startTime = Date() //This is when you STARTED THE TIMER, not to be used as the countown length
    private var firstStart = true
    private var timer = Timer()
    private var isTimerRunning = false
    
    override func customSetup() {
        timerLabel.text = "00:00:00"
        
        cancelButton.buttonAction = cancelButtonPressed
        startPauseButton.buttonAction = startPauseButtonPressed
        finishButton.buttonAction = finishButtonPressed

        buttonsStackView.addArrangedSubview(cancelButton)
        buttonsStackView.addArrangedSubview(startPauseButton)
        buttonsStackView.addArrangedSubview(finishButton)
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func updateColors() {
        cancelButton.colorTheme = parentVC.theme
        startPauseButton.colorTheme = parentVC.theme
        finishButton.colorTheme = parentVC.theme
    }
    
    func cancelButtonPressed() {
        let cancelPage = ConfirmationFactory.CancelConfirmation()
        cancelPage.methodToRunOnConfirm = cancel
        cancelPage.resetToDefault = true
        parentVC.pushSubView(newSubView: cancelPage)
    }
    
    func cancel() {}
    
    private func stopTimer() {
        startPauseButton.setResumeMode()
        descriptionLabel.text = pauseMessage
        
        timer.invalidate()
        isTimerRunning = false
    }
    
    private func resumeTimer() {
        startPauseButton.setPauseMode()
        descriptionLabel.text = resumeMessage
        
        runTimer()
        isTimerRunning = true
    }
    
    func startPauseButtonPressed() {
        if firstStart
        {
            firstStart = false
            startTime = Date()
        }
        if isTimerRunning {
            stopTimer()
        }
        else {
            resumeTimer()
        }
    }
    
    //Override to do stuff when pressed
    func finishButtonPressed() {
        stopTimer()
    }
    
    func pushFinishSVC(minutes: Int) {
        fatalError("Override finishButtonPressed")
    }
    
    //MARK: Run timer
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        changeSeconds()
        timerLabel.text = timeString(time:TimeInterval(seconds))
    }
    
    func changeSeconds(){
        fatalError("Override changeSeconds")
    }
    
    func timeString(time:TimeInterval) -> String {
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
    
    override func didLayoutSubviews(){
        // minimum font size 80, max font size 120
        // minimum height = 72, max height = 150
        DispatchQueue.main.async {
            print(self.frame.height)
        }
        let rate = 1 - ((712 - frame.height)) / 250
        
        let bigFontSize = 60  + (26) * rate
        let smallFontSize = 24  + (8) * rate
        let miniFontSize = 16 + (6) * rate
        let constraintConstant = 0 + (60) * rate
        let timerHeightConstant = 155 + (65) * rate

        DispatchQueue.main.async {
            self.timerLabel.font = UIFont(name: self.timerLabel!.font.fontName, size: bigFontSize)
            self.descriptionLabel.font = UIFont(name: self.descriptionLabel!.font.fontName, size: smallFontSize)
            self.SubDescriptionLabel.font = UIFont(name: self.SubDescriptionLabel!.font.fontName, size: miniFontSize)
            
            self.topConstraint.constant = constraintConstant
            self.timerHeight.constant = timerHeightConstant
        }
    }
    
}
