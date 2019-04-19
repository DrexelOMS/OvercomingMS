//
//  SettingsTrackingSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/18/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SettingsTrackingSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "SettingsTrackingSVC"
        }
    }
    
    let activeTracking = ActiveTrackingDBS()
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    @IBOutlet weak var foodToggle: UISwitch!
    @IBOutlet weak var omega3Toggle: UISwitch!
    @IBOutlet weak var vitaminDToggle: UISwitch!
    @IBOutlet weak var exerciseToggle: UISwitch!
    @IBOutlet weak var meditationToggle: UISwitch!
    @IBOutlet weak var medicationToggle: UISwitch!
    
    override func customSetup() {
        backButton.backButtonAction = backPressed
        
        let mostRecent = activeTracking.mostRecentActiveTracking
        foodToggle.isOn = mostRecent.IsFoodActive
        omega3Toggle.isOn = mostRecent.IsOmega3Active
        vitaminDToggle.isOn = mostRecent.IsVitaminDActive
        exerciseToggle.isOn = mostRecent.IsExerciseActive
        meditationToggle.isOn = mostRecent.IsMeditationActive
        medicationToggle.isOn = mostRecent.IsMedicationActive
    }
    
    func backPressed() {
        parentVC.popSubView()
    }
    
    @IBAction func foodToggled(_ sender: Any) {
        activeTracking.foodIsActive = foodToggle.isOn
        activeTracking.writeActiveItems()
    }
    
    @IBAction func omega3Toggled(_ sender: Any) {
        activeTracking.omega3IsActive = omega3Toggle.isOn
        activeTracking.writeActiveItems()
    }
    
    @IBAction func vitaminDToggled(_ sender: Any) {
        activeTracking.vitaminDIsActive = vitaminDToggle.isOn
        activeTracking.writeActiveItems()
    }
    
    @IBAction func exerciseToggled(_ sender: Any) {
        activeTracking.exerciseIsActive = exerciseToggle.isOn
        activeTracking.writeActiveItems()
    }
    
    @IBAction func meditationToggled(_ sender: Any) {
        activeTracking.meditationIsActive = meditationToggle.isOn
        activeTracking.writeActiveItems()
    }
    
    @IBAction func medicationToggled(_ sender: Any) {
        activeTracking.medicationIsActive = medicationToggle.isOn
        activeTracking.writeActiveItems()
    }
}
