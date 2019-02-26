//
//  MedRateButtonsSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MedRateButtonsSVC : CustomView {
    
    override var nibName: String {
        get {
            return "MedRateButtonsSVC"
        }
    }
    
    var rateString : String {
        get {
            let medicationRate = MedicationRateModel()
            medicationRate.monday = mondayButton.IsDone
            medicationRate.tuesday = tuesdayButton.IsDone
            medicationRate.wednesday = wedButton.IsDone
            medicationRate.thursday = thursButton.IsDone
            medicationRate.friday = fridayButton.IsDone
            medicationRate.saturday = satButton.IsDone
            medicationRate.sunday = sunButton.IsDone
            return medicationRate.rateString
        }
        set {
            let medicationRate = MedicationRateModel(rateString: newValue)
            mondayButton.IsDone = medicationRate.monday
            tuesdayButton.IsDone = medicationRate.tuesday
            wedButton.IsDone = medicationRate.wednesday
            thursButton.IsDone = medicationRate.thursday
            fridayButton.IsDone = medicationRate.friday
            satButton.IsDone = medicationRate.saturday
            sunButton.IsDone = medicationRate.sunday
        }
    }
    
    @IBOutlet weak var mondayButton: ToggleLabelCircleButton!
    @IBOutlet weak var tuesdayButton: ToggleLabelCircleButton!
    @IBOutlet weak var wedButton: ToggleLabelCircleButton!
    @IBOutlet weak var thursButton: ToggleLabelCircleButton!
    @IBOutlet weak var fridayButton: ToggleLabelCircleButton!
    @IBOutlet weak var satButton: ToggleLabelCircleButton!
    @IBOutlet weak var sunButton: ToggleLabelCircleButton!
    
    override func customSetup() {
    
    }
    
    //TODO: Add /Remve letter to rateString when toggled
    //TODO: make a way to set the rateString, and have it set the toggle state of the correct button
    
    @IBAction func buttonPressed(_ sender: ToggleLabelCircleButton) {
        sender.toggle()
    }

}