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
        foodGoalLabel.text = "Food Goal: \(ProgressBarConfig.foodRatingGoals)"
        omega3GoalLabel.text = "Omega3 Goal: \(ProgressBarConfig.omega3Goal)"
        vitaminDGoalLabel.text = "VitaminD Goal: \(ProgressBarConfig.vitaminDGoal)"
        exerciseGoalLabel.text = "Exercise Goal: \(ProgressBarConfig.exerciseGoal)"
        meditationGoalLabel.text = "Meditation Goal: \(ProgressBarConfig.meditationGoal)"
    }
    
    // Whatever happens, we must prevent user from setting a goal to 0
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        
        switch textField {
        case foodGoalTextField:
            ProgressBarConfig.foodRatingGoals = Int(textField.text ?? "") ?? ProgressBarConfig.foodRatingGoals
            break
        case omega3GoalTextField:
            ProgressBarConfig.omega3Goal = Int(textField.text ?? "") ?? ProgressBarConfig.omega3Goal
            break
        case vitaminDGoalTextField:
            ProgressBarConfig.vitaminDGoal = Int(textField.text ?? "") ?? ProgressBarConfig.vitaminDGoal
            break
        case exerciseGoalTextField:
            ProgressBarConfig.exerciseGoal = Int(textField.text ?? "") ?? ProgressBarConfig.exerciseGoal
            break
        case meditationGoalTextField:
            ProgressBarConfig.meditationGoal = Int(textField.text ?? "") ?? ProgressBarConfig.meditationGoal
            break
        default:
            break
        }
        
        reload()
        
        return true
    }
    
}
