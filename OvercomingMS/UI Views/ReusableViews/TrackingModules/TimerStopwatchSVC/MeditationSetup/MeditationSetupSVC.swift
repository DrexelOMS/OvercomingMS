//
//  MeditationSetupSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationTimerSetupAbstractSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "MeditationSetupSVC"
        }
    }
    
    @IBOutlet weak var mainViewContainer: UIView!
    @IBOutlet weak var defaultMainView: UIView!
    @IBOutlet weak var backButton: SquareButtonSVC!
    @IBOutlet weak var mainLabel: UILabel!
    
    override func customSetup() {

    }
    
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        backButton.colorTheme = parentVC.theme
        backButton.backButtonAction = parentVC.popSubView
    }
    
    override func reload() {
        
    }
    
}
