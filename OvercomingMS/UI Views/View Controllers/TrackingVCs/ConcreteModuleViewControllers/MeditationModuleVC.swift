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
    
    private let meditationHistory = MeditationHistoryDBS()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressBar.setTitle(title: "Meditation")
        
        initializeviewStack(defaultView: MeditationMainSVC())
    }
    
    override func updateProgressBar() {
        progressBar.setProgressValue(value: meditationHistory.getPercentageComplete())
        let amountRemaining = ProgressBarConfig.meditationGoal - meditationHistory.getTotalMinutes()
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
