//
//  GoalsSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/3/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class GoalsVC : SlidingStackVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeviewStack(defaultView: GoalsMainSVC())
    }
    
}
