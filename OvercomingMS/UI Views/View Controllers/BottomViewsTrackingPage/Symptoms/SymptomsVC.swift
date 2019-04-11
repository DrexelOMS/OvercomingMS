//
//  SymptomsVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SymptomsVC : TopImageSlidingStackVC {
    
    override var topImage: UIImage! {
        get {
            return UIImage(named: "Symptoms")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()   
        initializeviewStack(defaultView: SymptomsMainSVC())
    }
    
}
