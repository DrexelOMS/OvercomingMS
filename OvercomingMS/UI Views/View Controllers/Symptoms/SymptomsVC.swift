//
//  SymptomsVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SymptomsVC : SlidingStackVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeviewStack(defaultView: SymptomsMainSVC())
    }
    
}
