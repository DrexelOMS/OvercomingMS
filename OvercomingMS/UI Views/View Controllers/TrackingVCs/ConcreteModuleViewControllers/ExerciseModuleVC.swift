//
//  ExerciseModuleVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class ExerciseModuleVC: TrackingModuleAbstractVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentView = ExerciseMainSVC();
        currentView.parentVC = self
        mainView.addSubview(currentView)

        constrain(currentView, mainView) { currentView, mainView in
            currentView.top == mainView.top
            currentView.left == mainView.left
            currentView.right == mainView.right
            currentView.bottom == mainView.bottom
        }
    }

}
