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
        progressBar.toggleCheckMarkVisibility(isHidden: true)
        
        initializeviewStack(defaultView: MedicationMainSVC())
    }
    
    override func reload() {
        progressBar.update(trackingDBS: savedMedications)
    }

}
