//
//  ExerciseModuleVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class FoodModuleVC: SlidingStackVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initializeviewStack(defaultView: FoodMainSVC())
    }

}
