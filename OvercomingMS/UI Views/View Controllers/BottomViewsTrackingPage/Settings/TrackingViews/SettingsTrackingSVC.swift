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
    

    @IBOutlet weak var foodToggle: TrackingToggleSVC!
    @IBOutlet weak var omega3Toggle: TrackingToggleSVC!
    @IBOutlet weak var vitaminDToggle: TrackingToggleSVC!
    @IBOutlet weak var exerciseToggle: TrackingToggleSVC!
    @IBOutlet weak var meditationToggle: TrackingToggleSVC!
    @IBOutlet weak var medicationToggle: TrackingToggleSVC!
    
    override func customSetup() {
        backButton.backButtonAction = backPressed
        
        let mostRecent = activeTracking.mostRecentActiveTracking
        foodToggle.setToggle(isEnabled: mostRecent.IsFoodActive)
        foodToggle.toggleAction = foodToggled
        omega3Toggle.setToggle(isEnabled: mostRecent.IsOmega3Active)
        omega3Toggle.toggleAction = omega3Toggled
        vitaminDToggle.setToggle(isEnabled: mostRecent.IsVitaminDActive)
        vitaminDToggle.toggleAction = vitaminDToggled
        exerciseToggle.setToggle(isEnabled: mostRecent.IsExerciseActive)
        exerciseToggle.toggleAction = exerciseToggled
        meditationToggle.setToggle(isEnabled: mostRecent.IsMeditationActive)
        meditationToggle.toggleAction = meditationToggled
        medicationToggle.setToggle(isEnabled: mostRecent.IsMedicationActive)
        medicationToggle.toggleAction = medicationToggled
    }
    
    func backPressed() {
        parentVC.popSubView()
    }
    
    func foodToggled(isOn: Bool) {
        activeTracking.foodIsActive = isOn
        activeTracking.writeActiveItems()
    }
    
    func omega3Toggled(isOn: Bool) {
        activeTracking.omega3IsActive = isOn
        activeTracking.writeActiveItems()
    }
    
    func vitaminDToggled(isOn: Bool) {
        activeTracking.vitaminDIsActive = isOn
        activeTracking.writeActiveItems()
    }
    
    func exerciseToggled(isOn: Bool) {
        activeTracking.exerciseIsActive = isOn
        activeTracking.writeActiveItems()
    }
    
    func meditationToggled(isOn: Bool) {
        activeTracking.meditationIsActive = isOn
        activeTracking.writeActiveItems()
    }
    
    func medicationToggled(isOn: Bool) {
        activeTracking.medicationIsActive = isOn
        activeTracking.writeActiveItems()
    }
}
