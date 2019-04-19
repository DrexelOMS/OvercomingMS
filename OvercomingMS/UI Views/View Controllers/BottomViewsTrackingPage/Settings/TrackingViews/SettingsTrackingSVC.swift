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
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    @IBOutlet weak var foodToggle: UISwitch!
    @IBOutlet weak var omega3Toggle: UISwitch!
    @IBOutlet weak var vitaminDToggle: UISwitch!
    @IBOutlet weak var exerciseToggle: UISwitch!
    @IBOutlet weak var meditationToggle: UISwitch!
    @IBOutlet weak var medicationToggle: UISwitch!
    
    override func customSetup() {
        backButton.backButtonAction = backPressed
        
        foodToggle.isOn = true
        omega3Toggle.isOn = true
        vitaminDToggle.isOn = false
        exerciseToggle.isOn = true
        meditationToggle.isOn = true
        medicationToggle.isOn = false
    }
    
    func backPressed() {
        parentVC.popSubView()
    }
    
    @IBAction func foodToggled(_ sender: Any) {
        print("food")
    }
    
    @IBAction func omega3Toggled(_ sender: Any) {
        print("omega3")
    }
    
    @IBAction func vitaminDToggled(_ sender: Any) {
        print("vit")
    }
    
    @IBAction func exerciseToggled(_ sender: Any) {
        print("exercise")
    }
    
    @IBAction func meditationToggled(_ sender: Any) {
        print("meditation")
    }
    
    @IBAction func medicationToggled(_ sender: Any) {
        print(medicationToggle.isOn)
    }
}
