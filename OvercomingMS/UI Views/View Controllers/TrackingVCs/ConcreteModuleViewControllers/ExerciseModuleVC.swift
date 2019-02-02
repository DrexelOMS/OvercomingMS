//
//  ExerciseModuleVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ExerciseModuleVC: TrackingModuleAbstractVC {
    
    let exerciseRoutines = ExerciseRoutinesDBS()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeStackView(defaultView: ExerciseMainSVC())
    }
    
    func addDataItem(){
        exerciseRoutines.addExerciseItem(routineType: "Test", startTime: Date(), endTime: Date().addingTimeInterval(60*5))
        updateProgressBarMain(mainPercentage: exerciseRoutines.getTrackingDay()?.ExerciseComputedPercentageComplete ?? 0)
    }

}
