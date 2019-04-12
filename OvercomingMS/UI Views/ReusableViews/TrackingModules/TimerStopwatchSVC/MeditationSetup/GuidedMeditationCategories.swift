//
//  MeditationSetupSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class GuidedMeditationCategories : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "MeditationSetupSVC"
        }
    }
    
    @IBOutlet weak var mainViewContainer: UIView!
    @IBOutlet weak var defaultMainView: UIView!
    @IBOutlet weak var backButton: SquareButtonSVC!
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var level1Button: MeditationLevelButtonSVC!
    @IBOutlet weak var level2Button: MeditationLevelButtonSVC!
    @IBOutlet weak var level3Button: MeditationLevelButtonSVC!
    @IBOutlet weak var level4Button: MeditationLevelButtonSVC!
    
    
    override func customSetup() {
        mainLabel.text = "Chose a level:"
        
        level1Button.buttonAction = pushTimerWithLength
        level2Button.buttonAction = pushTimerWithLength
        level3Button.buttonAction = pushTimerWithLength
        level4Button.buttonAction = pushTimerWithLength
    }
    
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        backButton.colorTheme = parentVC.theme
        backButton.backButtonAction = parentVC.popSubView
    }
    
    override func reload() {
        
    }
    
    //TODO: have this push to the timer view view a convenience init
    func pushTimerWithLength(_ length: Int, _ type: String) {
        parentVC.pushSubView(newSubView: MeditationTimerSVC(startingSeconds: length * 60, meditationType: type))
    }
    
}