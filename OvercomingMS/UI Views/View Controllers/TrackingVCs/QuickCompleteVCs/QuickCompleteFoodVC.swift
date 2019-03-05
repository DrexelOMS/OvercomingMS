//
//  QuickCompleteFoodVCViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class QuickCompleteFoodVC: SwipeDownCloseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeviewStack(defaultView: FoodQuickCompleteSVC())
    }

}
