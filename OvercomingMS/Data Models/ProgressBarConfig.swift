//
//  ProgressBarConfig.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation

enum TrackingMode { case food, omega3, vitaminD, exercise, meditation, medication }

class ProgressBarConfig {
    
    //TODO: make food goal setable and usable?
    static var foodDescriptions : [String] = ["Aweful.", "Not great.", "Alright.", "Pretty good.", "Perfect!"]
    static func getfoodDescription(rating: Int) -> String {
        if(rating - 1 < 0){
            return foodDescriptions[0]
        }
        else if(rating - 1 >= foodDescriptions.count){
            return foodDescriptions[foodDescriptions.count - 1]
        }
        return foodDescriptions[rating - 1]
    }
    static var foodRatingGoals: Int {
        get {
            return GoalsDBS().mostRecentGoals.FoodRatingGoal
        }
        set {
            let goalsDBS = GoalsDBS()
            goalsDBS.foodRatingGoalToSet = newValue
            goalsDBS.writeGoals()
        }
    }
    
    static var omega3Goal : Int {
        get {
            return GoalsDBS().mostRecentGoals.Omega3Goal
        }
        set {
            let goalsDBS = GoalsDBS()
            goalsDBS.omega3GoalToSet = newValue
            goalsDBS.writeGoals()
        }
    }
    static let omega3UOM = "g."
    
    static var vitaminDGoal : Int {
        get {
            return GoalsDBS().mostRecentGoals.VitaminDGoal
        }
        set {
            let goalsDBS = GoalsDBS()
            goalsDBS.vitaminDGoalToSet = newValue
            goalsDBS.writeGoals()
        }
    }
    static let vitaminDUOM = "klUs"
    
    static var exerciseGoal : Int {
        get {
            return GoalsDBS().mostRecentGoals.ExerciseGoal
        }
        set {
            let goalsDBS = GoalsDBS()
            goalsDBS.exerciseGoalToSet = newValue
            goalsDBS.writeGoals()
        }
    }
    
    static var meditationGoal : Int {
        get {
            return GoalsDBS().mostRecentGoals.MeditationGoal
        }
        set {
            let goalsDBS = GoalsDBS()
            goalsDBS.meditationGoalToSet = newValue
            goalsDBS.writeGoals()
        }
    }
    
    static let lengthUOM = "min."
    
    static func calculateKLUs(minutes: Int) -> Int {
        return minutes * 5
    }

}

//extension UserDefaults {
//    func contains(key: String) -> Bool {
//        return UserDefaults.standard.object(forKey: key) != nil
//    }
//}
