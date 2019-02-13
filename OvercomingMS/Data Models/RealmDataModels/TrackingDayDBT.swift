//
//  TrackingDay.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/20/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class TrackingDayDBT: Object {
    let primaryKey = "Primary-Key"
    @objc dynamic var DateCreated: String = ""
    @objc dynamic var FollowProgramStreak: Int = 0
    
    //We save both percentage complete and their total so if we ever change the requirement
    //of completeness, we can remember that their percentage and use that if available
    //and update newer entries to use the new conversion of total
    @objc dynamic var FoodEatenRating: Int = 1 // Lets define the food scale as 1-5

    @objc dynamic var VitaminDPercentageComplete: Int = 0
    @objc dynamic var VitaminDTotal: Int = 0
    
    // ------------------------------ EXERCISE ------------------------------
    @objc dynamic var IsExerciseComplete: Bool = false //This should be read only
    var ExerciseComputedPercentageComplete : Int {
        get {
            if IsExerciseComplete {
                return 100
            }
            else {
                let percentage = Int(Float(ExerciseTimeTotal) / Float(ProgressBarConfig.exerciseGoal) * 100)
                if percentage > 100 {
                    return 100
                }
                else {
                    return percentage
                }
            }
        }
    }
    var ExerciseTimeTotal: Int {
        get {
            var totalMinutes = 0
            for row in exerciseHistoryDT {
                totalMinutes += row.minutes
            }
            return totalMinutes
        }
    }
    let exerciseHistoryDT = List<ExerciseHistoryDBT>()
    
    // --------------------- MEDITATION ------------------------------

    @objc dynamic var IsMeditationComplete: Bool = false
    var MeditationComputedPercentageComplete : Int {
        get {
            if IsMeditationComplete {
                return 100
            }
            else {
                let percentage = Int(Float(MeditationTimeTotal) / Float(ProgressBarConfig.meditationGoal) * 100)
                if percentage > 100 {
                    return 100
                }
                else {
                    return percentage
                }
            }
        }
    }
    
    
    var MeditationTimeTotal: Int {
        get {
            var totalMinutes = 0
            for row in meditationHistoryDT {
                totalMinutes += row.minutes
            }
            return totalMinutes
        }
    }
    
    let meditationHistoryDT = List<MeditationHistoryDBT>()
    
    
    // ---------------------- MEDICATION ------------------------------

    @objc dynamic var MedicationPercentageComplete: Int = 0
    @objc dynamic var MedicationTotal: Int = 0 //currently guess they would add a number of medications
    //you can only take a medication or not, but you could take 2 / 3 for some reason
    

    
    // ---------------------- OMEGA-3 ------------------------------
    
    // @objc dynamic var Omega3PercentageComplete: Int = 0
    
    @objc dynamic var IsOmega3Complete: Bool = false
    var Omega3ComputedPercentageComplete : Int {
        get {
            if IsOmega3Complete {
                return 100
            }
            else {
                let percentage = Int(Float(Omega3Total) / Float(ProgressBarConfig.omega3Goal) * 100)
                if percentage > 100 {
                    return 100
                }
                else {
                    return percentage
                }
            }
        }
    }
    
    var Omega3Total: Int {
        get {
            var totalGrams = 0
            for row in omega3HistoryDT {
                totalGrams += row.Amount
            }
            return totalGrams
        }
    }
    
    let omega3HistoryDT = List<Omega3HistoryDBT>()

    
    //Links to data tables
    //FoodStats  let dietStats = List<FoodStats>() or @objc dynamic var category: Category!
    //ExcersizeRoutines
    //MeditationRoutines
    //MedicationRoutines
    //Note that Routines are different from a standard list saved on the phone
    //which they can save and add custom routine names
    
    override static func primaryKey() -> String? {
        return "DateCreated"
    }
    
    
    
}
