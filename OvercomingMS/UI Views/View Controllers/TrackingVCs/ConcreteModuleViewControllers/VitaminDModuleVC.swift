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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressBar.setTitle(title: "Vitamin D")
        
        initializeviewStack(defaultView: VitaminDMainSVC())
    }
    
    override func reload() {
        progressBar.setProgressValue(value: vitaminDHistory.getPercentageComplete())
        let amountRemaining = ProgressBarConfig.vitaminDGoal - vitaminDHistory.getTotalAmount()
        var description = ""
        if(amountRemaining <= 0){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) \(ProgressBarConfig.vitaminDUOM) left"
        }
        progressBar.setDescription(description: description)
    }

}
