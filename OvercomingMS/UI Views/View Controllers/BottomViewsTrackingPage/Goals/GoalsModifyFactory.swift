//
//  GoalsModifyFactory.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/16/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class GoalsModifyFactory {
    
    static func FoodGoalsModifySVC() -> GoalsModifySVC {
        let svc = GoalsModifySVC(low: 2, high: 5)
        
        //Initialize Variables
        svc.header.titleText = "Food"
        svc.header.descriptionText = "What is your daily goal for Food"
        svc.currentGoalLabel.text = String(ProgressBarConfig.foodRatingGoals)
        svc.goalUnitLabel.text = "\(ProgressBarConfig.foodRatingGoals)/5"
        svc.Module = .Food
        svc.goal = ProgressBarConfig.foodRatingGoals
        
        return svc
    }
    
    static func Omega3GoalsModifySVC() -> GoalsModifySVC {
        let svc = GoalsModifySVC()
        
        //Initialize Variables
        svc.header.titleText = "Omega 3"
        svc.header.descriptionText = "What is your daily goal for Omega 3"
        svc.currentGoalLabel.text = String(ProgressBarConfig.omega3Goal)
        svc.goalUnitLabel.text = "grams"
        svc.Module = .Omega3
        svc.goal = ProgressBarConfig.omega3Goal
        
        return svc
    }
    
    static func VitaminDGoalsModifySVC() -> GoalsModifySVC {
        let svc = GoalsModifySVC()
        
        //Initialize Variables
        svc.header.titleText = "Vitamin D"
        svc.header.descriptionText = "What is your daily goal for Vitamin D"
        svc.currentGoalLabel.text = String(ProgressBarConfig.vitaminDGoal)
        svc.goalUnitLabel.text = "ulKs"
        svc.Module = .VitaminD
        svc.goal = ProgressBarConfig.vitaminDGoal
        
        return svc
    }
    
    static func ExerciseGoalsModifySVC() -> GoalsModifySVC {
        let svc = GoalsModifySVC()
        
        //Initialize Variables
        svc.header.titleText = "Exercise"
        svc.header.descriptionText = "What is your daily goal for Exercise"
        svc.currentGoalLabel.text = String(ProgressBarConfig.exerciseGoal)
        svc.goalUnitLabel.text = "Minutes"
        svc.Module = .Exercise
        svc.goal = ProgressBarConfig.exerciseGoal
        
        return svc
    }
    
    static func MeditationGoalsModifySVC() -> GoalsModifySVC {
        let svc = GoalsModifySVC()
        
        //Initialize Variables
        svc.header.titleText = "Meditation"
        svc.header.descriptionText = "What is your daily goal for Meditation"
        svc.currentGoalLabel.text = String(ProgressBarConfig.meditationGoal)
        svc.goalUnitLabel.text = "Minutes"
        svc.Module = .Meditation
        svc.goal = ProgressBarConfig.meditationGoal
        
        return svc
    }

}
