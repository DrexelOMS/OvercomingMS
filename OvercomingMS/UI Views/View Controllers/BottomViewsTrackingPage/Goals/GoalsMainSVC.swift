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
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    override func customSetup() {
        foodButton.buttonAction = foodPressed
        omega3Button.buttonAction = omega3Pressed
        vitaminDButton.buttonAction = vitaminDPressed
        exerciseButton.buttonAction = exercisePressed
        meditationButton.buttonAction = meditationPressed
    }
    
    override func reload() {
        foodButton.goalDescription = "\(ProgressBarConfig.getfoodDescription(rating: ProgressBarConfig.foodRatingGoal))"
        omega3Button.goalDescription = "\(ProgressBarConfig.omega3Goal) \(ProgressBarConfig.omega3UOM)"
        vitaminDButton.goalDescription = "\(ProgressBarConfig.vitaminDGoal)k IUs"
        exerciseButton.goalDescription = "\(ProgressBarConfig.exerciseGoal) \(ProgressBarConfig.lengthUOM)"
        meditationButton.goalDescription = "\(ProgressBarConfig.meditationGoal) \(ProgressBarConfig.lengthUOM)"
    }
    
    func foodPressed() {
        let svc = GoalsModifyFactory.FoodGoalsModifySVC()
        parentVC.theme = foodButton.colorTheme
        parentVC.pushSubView(newSubView: svc)
        svc.reload()
    }
    
    func omega3Pressed() {
        let svc = GoalsModifyFactory.Omega3GoalsModifySVC()
        parentVC.theme = omega3Button.colorTheme
        parentVC.pushSubView(newSubView: svc)
        svc.reload()
    }
    
    func vitaminDPressed() {
        let svc = GoalsModifyFactory.VitaminDGoalsModifySVC()
        parentVC.theme = vitaminDButton.colorTheme
        parentVC.pushSubView(newSubView: svc)
        svc.reload()
    }
    
    func exercisePressed() {
        let svc = GoalsModifyFactory.ExerciseGoalsModifySVC()
        parentVC.theme = exerciseButton.colorTheme
        parentVC.pushSubView(newSubView: svc)
        svc.reload()
    }
    
    func meditationPressed() {
        let svc = GoalsModifyFactory.MeditationGoalsModifySVC()
        parentVC.theme = meditationButton.colorTheme
        parentVC.pushSubView(newSubView: svc)
        svc.reload()
    }
    
    @IBAction func reset(_ sender: Any) {
        let svc = ConfirmationSVC()
        svc.topDescription.text = "You are reseting all daily goals to OMS recommended goals"
        svc.bottomDescription.text = "Is this correct?"
        svc.methodToRunOnConfirm = resetGoalsToDefault
        parentVC.pushSubView(newSubView: svc)
    }
    
    func resetGoalsToDefault() {
        let defaultGoals = GoalsDBT()
        
        ProgressBarConfig.foodRatingGoal = defaultGoals.FoodRatingGoal
        ProgressBarConfig.omega3Goal = defaultGoals.Omega3Goal
        ProgressBarConfig.vitaminDGoal = defaultGoals.VitaminDGoal
        ProgressBarConfig.exerciseGoal = defaultGoals.ExerciseGoal
        ProgressBarConfig.meditationGoal = defaultGoals.MeditationGoal
        
        reload()
    }

    @IBOutlet weak var stackViewLeft: NSLayoutConstraint!
    @IBOutlet weak var stackViewRight: NSLayoutConstraint!
    @IBOutlet weak var resetLabel: UILabel!
    @IBOutlet weak var resetLabelHeight: NSLayoutConstraint!
    
    override func layoutSubviews() {
        DispatchQueue.main.async {
            var rate = 1 - ((896 -  UIScreen.main.bounds.height)) / 328
            rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
            
            let fontSize = 16 + (4) * rate
            let padding = 30 + (10) * rate
            let height = 80 + (20) * rate
            
            self.headerHeightConstraint.constant = height
            self.resetLabelHeight.constant = 50 + (20) * rate
            self.stackViewLeft.constant = padding
            self.stackViewRight.constant = padding
            
            self.resetLabel.font = UIFont(name: self.resetLabel!.font.fontName, size: fontSize)
            
        }
    }
}
