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
    
    private let savedMedications = SavedMedicationDBS()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressBar.setTitle(title: "Medication")
        
        initializeviewStack(defaultView: MedicationMainSVC())
    }
    
    override func reload() {
        progressBar.setProgressValue(value: savedMedications.getPercentageComplete())
        let amountRemaining = savedMedications.getTodaysTotalMedGoal() - savedMedications.getTrackingDay()!.MedicationTotal
        var description = ""
        if(amountRemaining <= 0){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) meds left"
        }
        progressBar.setDescription(description: description)
    }

}
