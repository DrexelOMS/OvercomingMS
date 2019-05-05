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
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
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
        descriptionLabel.text = "Workout paused."
        
        timer.invalidate()
        isTimerRunning = false
    }
    
    private func resumeTimer() {
        startPauseButton.setPauseMode()
        descriptionLabel.text = "Keep going!"
        
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
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
    }
    
}
