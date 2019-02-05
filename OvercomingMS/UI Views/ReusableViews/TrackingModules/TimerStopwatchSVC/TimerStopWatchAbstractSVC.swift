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
    
    private var timerStarted = false
    
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
        if timerStarted {
            startPauseButton.labelName = "Start"
            //StartTimer
        }
        else {
            startPauseButton.labelName = "Pause"
            //StopTimer
        }
        timerStarted = !timerStarted
    }
    
    func finishButtonPressed() {
        
    }
    
}
