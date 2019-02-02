//
//  ConfirmationSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ConfirmationSVC: SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "ConfirmationSVC"
        }
    }
    
    override func customSetup() {
        
    }
    
    override func updateColors() {
        
    }
    
    //TODO use a stored function passed by the one using
    @IBAction func backButtonPressed(_ sender: UIButton) {
        parentVC.resetToDefaultView()
    }
    
}
