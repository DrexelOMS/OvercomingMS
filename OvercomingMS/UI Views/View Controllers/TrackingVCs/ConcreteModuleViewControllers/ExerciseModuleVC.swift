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
    
    private let exerciseHistory = ExerciseHistoryDBS()
    private let progressBar = ExerciseProgressBar()
    
    override func getProgressBar() -> TrackingProgressBar {
        return progressBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressBar.setTitle(title: "Exercise")
        progressBar.toggleCheckMarkVisibility(isHidden: true)
        
        initializeviewStack(defaultView: ExerciseMainSVC())
    }
    
    override func reload() {
        progressBar.updateProgress()
    }

}
