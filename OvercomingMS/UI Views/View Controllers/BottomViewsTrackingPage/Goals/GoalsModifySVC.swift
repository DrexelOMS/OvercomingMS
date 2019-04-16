//
//  GoalsModifySVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/12/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class GoalsModifySVC: SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "GoalsModifySVC"
        }
    }
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    override func customSetup() {
        backButton.backButtonAction = backPressed
    }
    
    func backPressed() {
        parentVC.popSubView()
    }
    
}
