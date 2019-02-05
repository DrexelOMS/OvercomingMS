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
    
    let cancelButton = CancelCircleButton()
    let startPauseButton = StartPauseCircleButton()
    let finishButton = FinishCircleButton()
    
    private var seconds = 0
    private var startTime = Date()
    private var firstStart = true
    private var timer = Timer()
    private var isTimerRunning = false
    
    let exerciseRoutines : ExerciseRoutinesDBS = ExerciseRoutinesDBS()
    
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
        parentVC.popSubView()
    }
    
    func startPauseButtonPressed() {
        if firstStart
        {
            firstStart = false
            startTime = Date()
        }
        if isTimerRunning {
            startPauseButton.labelName = "Resume"
            //StartTimer
            timer.invalidate()
        }
        else {
            startPauseButton.labelName = "Pause"
            //StopTimer
            runTimer()
        }
        isTimerRunning = !isTimerRunning
    }
    
    func finishButtonPressed() {
        exerciseRoutines.addExerciseItem(routineType: "Workout", startTime: startTime, endTime: startTime.addingTimeInterval(TimeInterval(seconds * 60)))
       
        parentVC.popSubView()
    }
    
//    private func ResetButtonTapped(){
//        timer.invalidate()
//        seconds = 60
//        CountDownLabel.text = timeString(time:TimeInterval(seconds))
//        isTimerRunning = false
//    }
    
    
    //MARK: Run timer
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        seconds += 1
        timerLabel.text = timeString(time:TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
    }
    
}
