//
//  ExerciseModuleVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class MeditationModuleVC: TrackingModuleAbstractVC {
    
    private let meditationRoutines = MeditationHistoryDBS()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressBar.setTitle(title: "Meditation")
        
        //initializeStackView(defaultView: ExerciseMainSVC())
    }
    
    override func updateProgressBar() {
        progressBar.setProgressValue(value: meditationRoutines.getPercentageComplete())
        let amountRemaining = ProgressBarConfig.meditationGoal - meditationRoutines.getTotalMinutes()
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
