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
        let view = ExerciseMainSVC();
        view.parentVC = self
        mainView.addSubview(view)

        constrain(view, mainView) { view, mainView in
            view.top == mainView.top
            view.left == mainView.left
            view.right == mainView.right
            view.bottom == mainView.bottom
        }
    }

}
