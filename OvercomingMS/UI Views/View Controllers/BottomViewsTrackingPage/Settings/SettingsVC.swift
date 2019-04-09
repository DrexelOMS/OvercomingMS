//
//  SettingsVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SettingsVC : TopImageSlidingStackVC {
    
    override var topImage: UIImage! {
        get {
            return UIImage(named: "Add")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeviewStack(defaultView: SettingsMainSVC())
    }
    
}
