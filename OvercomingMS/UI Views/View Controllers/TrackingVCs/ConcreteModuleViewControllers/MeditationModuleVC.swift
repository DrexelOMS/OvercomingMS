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
        progressBar.toggleCheckMarkVisibility(isHidden: true)
        
        initializeviewStack(defaultView: MeditationMainSVC())
    }
    
    override func reload() {
        progressBar.update(trackingDBS: meditationHistory)
    }

}
