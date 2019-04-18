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

    @IBOutlet weak var foodButton: GoalsBoxSVC!
    @IBOutlet weak var omega3Button: GoalsBoxSVC!
    @IBOutlet weak var vitaminDButton: GoalsBoxSVC!
    @IBOutlet weak var exerciseButton: GoalsBoxSVC!
    @IBOutlet weak var meditationButton: GoalsBoxSVC!
    
    override func customSetup() {
        foodButton.buttonAction = foodPressed
        omega3Button.buttonAction = omega3Pressed
        vitaminDButton.buttonAction = vitaminDPressed
        exerciseButton.buttonAction = exercisePressed
        meditationButton.buttonAction = meditationPressed
    }
    
    override func reload() {
        foodButton.goalDescription = "\(ProgressBarConfig.foodDescriptions[ProgressBarConfig.foodRatingGoals]) (\(ProgressBarConfig.foodRatingGoals)/5)"
        omega3Button.goalDescription = "\(ProgressBarConfig.omega3Goal) \(ProgressBarConfig.omega3UOM)"
        vitaminDButton.goalDescription = "\(ProgressBarConfig.vitaminDGoal) \(ProgressBarConfig.vitaminDUOM)"
        exerciseButton.goalDescription = "\(ProgressBarConfig.exerciseGoal) \(ProgressBarConfig.lengthUOM)"
        meditationButton.goalDescription = "\(ProgressBarConfig.meditationGoal) \(ProgressBarConfig.lengthUOM)"
    }
    
    // Whatever happens, we must prevent user from setting a goal to 0
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        endEditing(true)
//
//        switch textField {
//        case foodGoalTextField:
//            ProgressBarConfig.foodRatingGoals = Int(textField.text ?? "") ?? ProgressBarConfig.foodRatingGoals
//            break
//        case omega3GoalTextField:
//            ProgressBarConfig.omega3Goal = Int(textField.text ?? "") ?? ProgressBarConfig.omega3Goal
//            break
//        case vitaminDGoalTextField:
//            ProgressBarConfig.vitaminDGoal = Int(textField.text ?? "") ?? ProgressBarConfig.vitaminDGoal
//            break
//        case exerciseGoalTextField:
//            ProgressBarConfig.exerciseGoal = Int(textField.text ?? "") ?? ProgressBarConfig.exerciseGoal
//            break
//        case meditationGoalTextField:
//            ProgressBarConfig.meditationGoal = Int(textField.text ?? "") ?? ProgressBarConfig.meditationGoal
//            break
//        default:
//            break
//        }
//
//        reload()
//
//        return true
//    }
    
    func foodPressed() {
        
    }
    
    func omega3Pressed() {
        
    }
    
    func vitaminDPressed() {
        
    }
    
    func exercisePressed() {
        parentVC.pushSubView(newSubView: GoalsModifyFactory.ExerciseGoalsModifySVC())
    }
    
    func meditationPressed() {
        
    }
    
}
