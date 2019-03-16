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
    
    override func reload() {
        progressBar.setProgressValue(value: meditationHistory.getPercentageComplete())
        progressBar.setDescription(amountRemaining: ProgressBarConfig.meditationGoal - meditationHistory.getTotalMinutes(), uom: ProgressBarConfig.lengthUOM)
    }

}
