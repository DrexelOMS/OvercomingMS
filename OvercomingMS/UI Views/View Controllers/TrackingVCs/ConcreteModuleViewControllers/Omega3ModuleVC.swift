//
//  ExerciseModuleVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class Omega3ModuleVC: TrackingModuleAbstractVC {
    
    private let omega3History = Omega3HistoryDBS()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressBar.setTitle(title: "Omega3")
        
        initializeStackView(defaultView: Omega3MainSVC())
    }
    
    override func updateProgressBar() {
        progressBar.setProgressValue(value: omega3History.getPercentageComplete())
        let amountRemaining = ProgressBarConfig.omega3Goal - omega3History.getTotalGrams()
        var description = ""
        if(amountRemaining <= 0){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) grams left"
        }
        progressBar.setDescription(description: description)
    }

}
