//
//  GoalsDBS.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/8/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

//TODO: refactor to be much more efficient

class GoalsDBS {

    let realm = try! Realm()

    var foodRatingGoalToSet: Int?
    var omega3GoalToSet: Int?
    var vitaminDGoalToSet: Int?
    var exerciseGoalToSet: Int?
    var meditationGoalToSet: Int?
    
    //TODO: This list must be sorted from earliest to latest
    var goals: [GoalsDBT] {
        get {
            let results: Results<GoalsDBT> = realm.objects(GoalsDBT.self)
            let converted = results.reduce(List<GoalsDBT>()) { (list, element) -> List<GoalsDBT> in
                list.append(element)
                return list
            }
            let sortedList = converted.sorted(by: { OMSDateAccessor().lessThanComparison(left: OMSDateAccessor.getFullDate(date: $0.DateModified), right: OMSDateAccessor.getFullDate(date: $1.DateModified)) })
            return sortedList
        }
    }
    
    var mostRecentGoals: GoalsDBT {
        get {
            //To get the most recent items goals,
            // you need to start from the end, see if the date is before the global current day, if not, keep going back until the global current date is after or on the date of the current goal
            
            //cant get goals since we are in a write statement
            let currentDate = globalCurrentFullDate
            let da = OMSDateAccessor()
            let allGoals = goals
            
            var goalsToReturn: GoalsDBT = allGoals[allGoals.count - 1]
            for dayGoals in allGoals.reversed() {
                let date = OMSDateAccessor.getFullDate(date: dayGoals.DateModified)
                if da.greaterThanEqualComparison(left: currentDate, right: date) {
                    return dayGoals
                }
                goalsToReturn = dayGoals
            }
            return goalsToReturn
        }
    }
    
    //MARK: set todays goals
    //Usage is to set the goal variables, then call writeGoals()
    //Note: this is intended to support changing goals after the most recent goal, not before
    func writeGoals() {
        let date = globalCurrentDate
        do {
            try realm.safeWrite() {
                
                // on a date that has not had its goals set
                if mostRecentGoals.DateModified != date {
                    
                    let item = GoalsDBT()
                    let goals = mostRecentGoals
                    
                    item.FoodRatingGoal = foodRatingGoalToSet ?? goals.FoodRatingGoal
                    item.Omega3Goal = omega3GoalToSet ?? goals.Omega3Goal
                    item.VitaminDGoal = vitaminDGoalToSet ?? goals.VitaminDGoal
                    item.ExerciseGoal = exerciseGoalToSet ?? goals.ExerciseGoal
                    item.MeditationGoal =  meditationGoalToSet ?? goals.MeditationGoal
                    
                    item.DateModified = date
                    
                    realm.add(item)
                    
                }
                // modify some existing items goals
                else {
                    let goals = mostRecentGoals
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
        
        TrackingModulesDBS().updateAllStatus()
    }
    
    //set the first goal to the previous day
    func writeFirstDay() {
        do {
            try realm.safeWrite() {
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
                
                let date = globalCurrentFullDate.addingTimeInterval(-1 * 60 * 60 * 24) //set to yesterday
                item.DateModified = OMSDateAccessor.getFormatedDate(date: date)
                
                realm.add(item)
            }
        }
        catch {
            print("Error updating food data : \(error)" )
        }
    }

}
