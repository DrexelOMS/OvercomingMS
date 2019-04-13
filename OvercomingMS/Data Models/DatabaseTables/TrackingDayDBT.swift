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
    
    //MARK: ------------------------------ EXERCISE ------------------------------
    
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
    
    //MARK: --------------------- MEDITATION ------------------------------

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
    
    
    //MARK: ---------------------- MEDICATION ------------------------------
    
    @objc dynamic var IsMedicationComplete: Bool = false
    var MedicationComputedPercentageComplete : Int {
        get {
            if IsMedicationComplete {
                return 100
            }
            else {
                let todaysTotalMeds : Float = Float(SavedMedicationDBS().getTodaysTotalMedGoal())
                if todaysTotalMeds <= 0 {
                    return 100
                }
                let percentage = Int(Float(MedicationTotal) / Float(todaysTotalMeds) * 100)
                if percentage > 100 {
                    return 100
                }
                else {
                    return percentage
                }
            }
        }
    }
    
    var MedicationTotal: Int {
        get {
            return savedMedicationDT.count
        }
    }
    
    //currently guess they would add a number of medications
    //you can only take a medication or not, but you could take 2 / 3 for some reason
    
    //this will be count of medicationHistoryDT / count of savedMedications with some voodo shit with frequency
    var savedMedicationDT = List<SavedMedicationDBT>()
    
    //MARK: ---------------------- OMEGA-3 ------------------------------
    
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

    //MARK: -------------------------------- VITAMIN D ----------------------------------
    @objc dynamic var IsVitaminDComplete: Bool = false //This should be read only
    var VitaminDComputedPercentageComplete : Int {
        get {
            if IsVitaminDComplete {
                return 100
            }
            else {
                let percentage = Int(Float(VitaminDTotal) / Float(ProgressBarConfig.vitaminDGoal) * 100)
                if percentage > 100 {
                    return 100
                }
                else {
                    return percentage
                }
            }
        }
    }
    
    @objc dynamic var VitaminDTotal: Int {
        get {
            var totalAmount = 0
            for row in vitaminDHistoryDT {
                totalAmount += row.Amount
            }
            return totalAmount
        }
    }
    
    let vitaminDHistoryDT = List<VitaminDHistoryDBT>()
    
    //MARK: ---------------------- SYMPTOMS ------------------------------
    
    let symptomsNoteDT = List<SymptomsNoteDBT>()
    
    //MARK: ---------------------- SYMPTOMS ------------------------------
    
    let foodLogDT = List<FoodLogDBT>()
    
    //MARK: ---------------------- HELPERS -------------------------------
    
    var isDayComplete: Bool {
        get {
            return false
        }
    }
    
    override static func primaryKey() -> String? {
        return "DateCreated"
    }
    
}
