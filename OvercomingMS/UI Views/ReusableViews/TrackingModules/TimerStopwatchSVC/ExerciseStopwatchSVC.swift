//
//  ExerciseStopwatchSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ExerciseStopwatchSVC : StopwatchAbstractSVC {
   
    override func customSetup() {
        super.customSetup()
    }
    
    override func pushFinishSVC(minutes: Int) {
        parentVC.pushSubView(newSubView: ExerciseAddSVC(startTime: startTime, length: minutes))
    }
}
