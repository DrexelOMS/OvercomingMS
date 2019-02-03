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
    
    private let exerciseRoutines = ExerciseRoutinesDBS()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeStackView(defaultView: ExerciseMainSVC())
    }
    
    func addDataItem(){
        exerciseRoutines.addExerciseItem(routineType: "Test", startTime: Date(), endTime: Date().addingTimeInterval(60*5))
        updateProgressBarMain(mainPercentage: exerciseRoutines.getTrackingDay()?.ExerciseComputedPercentageComplete ?? 0)
    }

    func getExerciseItems() -> List<ExerciseRoutinesDBT>? {
        return exerciseRoutines.getExerciseItems()
    }
    
    func getTotalMinutes() -> Int {
        return exerciseRoutines.getTrackingDay()?.ExerciseTimeTotal ?? 0
    }
    
    func getPercentageComplete() -> Int {
        return exerciseRoutines.getTrackingDay()?.ExerciseComputedPercentageComplete ?? 0
    }
}
