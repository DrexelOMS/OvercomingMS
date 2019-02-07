//
//  ExerciseModuleVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class ExerciseModuleVC: TrackingModuleAbstractVC {
    
    private let exerciseRoutines = ExerciseHistoryDBS()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressBar.setTitle(title: "Exercise")
        
        initializeStackView(defaultView: ExerciseMainSVC())
    }
    
    override func updateProgressBar() {
        progressBar.setProgressValue(value: exerciseRoutines.getPercentageComplete())
        let amountRemaining = ProgressBarConfig.exerciseGoal - exerciseRoutines.getTotalMinutes()
        var description = ""
        if(amountRemaining <= 0){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) minutes left"
        }
        progressBar.setDescription(description: description)
    }

}
