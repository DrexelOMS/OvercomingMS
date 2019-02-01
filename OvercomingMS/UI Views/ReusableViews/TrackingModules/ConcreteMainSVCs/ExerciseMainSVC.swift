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
        parentVC.pushSubView(newSubView: ConfirmationSVC())
    }
    
    @IBAction func timerButtonPressed() {
        
    }


}
