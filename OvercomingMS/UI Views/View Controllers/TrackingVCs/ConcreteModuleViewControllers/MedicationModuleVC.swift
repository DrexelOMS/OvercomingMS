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
    private let progressBar = MedicationProgressBar()
    
    override func getProgressBar() -> TrackingProgressBar {
        return progressBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressBar.setTitle(title: "Medication")
        progressBar.toggleCheckMarkVisibility(isHidden: true)
        
        initializeviewStack(defaultView: MedicationMainSVC())
    }
    
    override func reload() {
        progressBar.updateProgress()
    }

}
