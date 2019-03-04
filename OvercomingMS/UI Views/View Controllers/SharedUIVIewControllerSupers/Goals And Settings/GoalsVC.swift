//
//  GoalsSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/3/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class GoalsVC : SwipeDownCloseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeviewStack(defaultView: GoalsMainSVC())
    }
    
}
