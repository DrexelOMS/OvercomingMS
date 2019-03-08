//
//  GoalsDBS.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/8/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class GoalsDBS {

    let realm = try! Realm()

    var foodRatingGoalToSet: Int?
    var omega3GoalToSet: Int?
    var vitaminDGoalToSet: Int?
    var exerciseGoalToSet: Int?
    var meditationGoalToSet: Int?
    
    private var goals: List<GoalsDBT> {
        get {
            let results: Results<GoalsDBT> = realm.objects(GoalsDBT.self)
            let converted = results.reduce(List<GoalsDBT>()) { (list, element) -> List<GoalsDBT> in
                list.append(element)
                return list
            }
            return converted
        }
    }
    
    var todaysGoals: GoalsDBT {
        get {
            return goals[0]
        }
    }
    
    //MARK: set todays goals
    //Usage is to set the goal variables, then call writeGoals()
    
    func writeGoals() {
        do {
            try realm.write() {
                
                if goals.count <= 0 {
                    
                    let item = GoalsDBT()
                    
                    if let foodG = foodRatingGoalToSet {
                        item.FoodRatingGoal = foodG
                    }
                    
                    if let omega3G = omega3GoalToSet {
                        item.Omega3Goal = omega3G
                    }
                    
                    if let vitaminDG = vitaminDGoalToSet {
                        item.VitaminDGoal = vitaminDG
                    }
                    
                    if let exerciseG = exerciseGoalToSet {
                        item.ExerciseGoal = exerciseG
                    }
                    
                    if let meditationG = meditationGoalToSet {
                        item.MeditationGoal = meditationG
                    }
                    
                    realm.add(item)
                }
                else {
                    let goals = todaysGoals
                    goals.FoodRatingGoal = foodRatingGoalToSet ?? goals.FoodRatingGoal
                    goals.Omega3Goal = omega3GoalToSet ?? goals.Omega3Goal
                    goals.VitaminDGoal = vitaminDGoalToSet ?? goals.VitaminDGoal
                    goals.ExerciseGoal = exerciseGoalToSet ?? goals.ExerciseGoal
                    goals.MeditationGoal =  meditationGoalToSet ?? goals.MeditationGoal
                }
            }
        } catch {
            print("Error updating goal : \(error)" )
        }
    }

    
}
