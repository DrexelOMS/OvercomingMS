//
//  ExerciseModuleVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class MedicationModuleVC: TrackingModuleAbstractVC {
    
    //private let medicationHistory = MedicationHistoryDBS()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressBar.setTitle(title: "Medication")
        
        initializeStackView(defaultView: MedicationMainSVC())
    }
    
    override func updateProgressBar() {
//        progressBar.setProgressValue(value: meditationRoutines.getPercentageComplete())
//        let amountRemaining = ProgressBarConfig.meditationGoal - meditationRoutines.getTotalMinutes()
//        var description = ""
//        if(amountRemaining <= 0){
//            description = "Daily goal reached!"
//        }
//        else {
//            description = "\(amountRemaining) minutes left"
//        }
//        progressBar.setDescription(description: description)
    }

}
