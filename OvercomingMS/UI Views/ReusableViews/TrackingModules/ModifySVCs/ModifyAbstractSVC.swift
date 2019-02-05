//
//  ModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ModifyAbstractSVC : SlidingAbstractSVC {
    
    
    
    override var nibName: String {
        get {
            return "ModifyAbstractSVC"
        }
    }
    
    override func customSetup() {
        
    }
    
    @IBAction func BackPressed(_ sender: Any) {
        parentVC.popSubView()
    }
    
    @IBAction func ConfirmPressed(_ sender: Any) {
        //AddItem
        parentVC.popSubView()
    }
    
}
