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
    
    private var medicationRate = MedicationRateModel()
    
    var rateModel : MedicationRateModel {
        get {
            medicationRate.dictionary["M"] = mondayButton.IsDone
            medicationRate.dictionary["T"] = tuesdayButton.IsDone
            medicationRate.dictionary["W"] = wedButton.IsDone
            medicationRate.dictionary["R"] = thursButton.IsDone
            medicationRate.dictionary["F"] = fridayButton.IsDone
            medicationRate.dictionary["S"] = satButton.IsDone
            medicationRate.dictionary["U"] = sunButton.IsDone
            
            return medicationRate
        }
        set {
            let medicationRate = newValue
            mondayButton.IsDone = medicationRate.dictionary["M"]!
            tuesdayButton.IsDone = medicationRate.dictionary["T"]!
            wedButton.IsDone = medicationRate.dictionary["W"]!
            thursButton.IsDone = medicationRate.dictionary["R"]!
            fridayButton.IsDone = medicationRate.dictionary["F"]!
            satButton.IsDone = medicationRate.dictionary["S"]!
            sunButton.IsDone = medicationRate.dictionary["U"]!
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
