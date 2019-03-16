//
//  ExerciseModuleVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class VitaminDModuleVC: TrackingModuleAbstractVC {
    
    private let vitaminDHistory = VitaminDHistoryDBS()
    private let progressBar = VitaminDProgressBar()
    
    override func getProgressBar() -> TrackingProgressBar {
        return progressBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressBar.setTitle(title: "Vitamin D")
        progressBar.toggleCheckMarkVisibility(isHidden: true)
        
        initializeviewStack(defaultView: VitaminDMainSVC())
    }
    
    override func reload() {
        progressBar.updateProgress()
    }

}
