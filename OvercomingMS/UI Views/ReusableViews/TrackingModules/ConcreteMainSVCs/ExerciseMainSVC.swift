//
//  ExerciseMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ExerciseMainSVC: MainAbstractSVC {

    override var nibName: String {
        get {
            return "ExerciseMainSVC"
        }
    }
    
    @IBAction func addButtonPressed() {
        //parentVC.pushSubView(newSubView: ExerciseMainSVC())
        print("Adding 5 Minute Test Routine")
        ExerciseRoutinesDBS().addExerciseItem(routineType: "Test", startTime: Date(), endTime: Date().addingTimeInterval(60*5))
    }
    
    @IBAction func timerButtonPressed() {
        parentVC.pushSubView(newSubView: ConfirmationSVC())
    }
    
    @IBAction func backButtonPressed() {
        parentVC.popSubView()
    }


}
