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
        foodButton.goalDescription = "\(ProgressBarConfig.getfoodDescription(rating: ProgressBarConfig.foodRatingGoals)) (\(ProgressBarConfig.foodRatingGoals)/5)"
        omega3Button.goalDescription = "\(ProgressBarConfig.omega3Goal) \(ProgressBarConfig.omega3UOM)"
        vitaminDButton.goalDescription = "\(ProgressBarConfig.vitaminDGoal) \(ProgressBarConfig.vitaminDUOM)"
        exerciseButton.goalDescription = "\(ProgressBarConfig.exerciseGoal) \(ProgressBarConfig.lengthUOM)"
        meditationButton.goalDescription = "\(ProgressBarConfig.meditationGoal) \(ProgressBarConfig.lengthUOM)"
    }
    
    func foodPressed() {
        let svc = GoalsModifyFactory.FoodGoalsModifySVC()
        parentVC.pushSubView(newSubView: svc)
        svc.reload()
    }
    
    func omega3Pressed() {
        let svc = GoalsModifyFactory.Omega3GoalsModifySVC()
        parentVC.pushSubView(newSubView: svc)
        svc.reload()
    }
    
    func vitaminDPressed() {
        let svc = GoalsModifyFactory.VitaminDGoalsModifySVC()
        parentVC.pushSubView(newSubView: svc)
        svc.reload()
    }
    
    func exercisePressed() {
        let svc = GoalsModifyFactory.ExerciseGoalsModifySVC()
        parentVC.pushSubView(newSubView: svc)
        svc.reload()
    }
    
    func meditationPressed() {
        let svc = GoalsModifyFactory.MeditationGoalsModifySVC()
        parentVC.pushSubView(newSubView: svc)
        svc.reload()
    }
    
}
