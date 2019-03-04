//
//  GoalsMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/3/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class GoalsMainSVC : SlidingAbstractSVC, UITextFieldDelegate {
    
    override var nibName: String {
        get {
            return "GoalsMainSVC"
        }
    }
    
    @IBOutlet weak var foodGoalLabel: UILabel!
    @IBOutlet weak var omega3GoalLabel: UILabel!
    @IBOutlet weak var vitaminDGoalLabel: UILabel!
    @IBOutlet weak var exerciseGoalLabel: UILabel!
    @IBOutlet weak var meditationGoalLabel: UILabel!
    
    @IBOutlet weak var foodGoalTextField: UITextField!
    @IBOutlet weak var omega3GoalTextField: UITextField!
    @IBOutlet weak var vitaminDGoalTextField: UITextField!
    @IBOutlet weak var exerciseGoalTextField: UITextField!
    @IBOutlet weak var meditationGoalTextField: UITextField!
    
    override func customSetup() {
        foodGoalTextField.delegate = self
        omega3GoalTextField.delegate = self
        vitaminDGoalTextField.delegate = self
        exerciseGoalTextField.delegate = self
        meditationGoalTextField.delegate = self
    }
    
    override func reload() {
        print("reloaded")
        foodGoalLabel.text = "Food Goal: "
        omega3GoalLabel.text = "Omega3 Goal: "
        vitaminDGoalLabel.text = "VitaminD Goal: "
        exerciseGoalLabel.text = "Exercise Goal: "
        meditationGoalLabel.text = "Meditation Goal: "
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        
        switch textField {
        case foodGoalTextField:
            foodGoalLabel.text = textField.text ?? ""
            break
        case omega3GoalTextField:
            omega3GoalLabel.text = textField.text ?? ""
            break
        case vitaminDGoalTextField:
            vitaminDGoalLabel.text = textField.text ?? ""
            break
        case exerciseGoalTextField:
            exerciseGoalLabel.text = textField.text ?? ""
            break
        case meditationGoalTextField:
            meditationGoalLabel.text = textField.text ?? ""
            break
        default:
            break
        }
        
        return true
    }
    
}
