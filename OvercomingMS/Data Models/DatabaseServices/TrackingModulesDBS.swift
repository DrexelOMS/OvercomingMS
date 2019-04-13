//
//  AbstractDBS.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

enum Modules {
    case Food,
    Omega3,
    VitaminD,
    Exercise,
    Meditation,
    Medication
}

class TrackingModulesDBS{
    
    let realm = try! Realm()
    let QUICK_COMPLETE = "Quick Complete"
    
    var module : Modules {
        get {
            fatalError("forgot to Override Module")
        }
    }

    func getTrackingDay(date: String = globalCurrentDate) -> TrackingDayDBT {
        if let trackingDay = realm.object(ofType: TrackingDayDBT.self, forPrimaryKey: date) {
            return trackingDay
        }
        else {
            initializeTodaysData(date: date)
            return getTrackingDay(date: date)
        }
    }
    
    // only to be used by getTrackingDay
    private func initializeTodaysData(date : String) {
        do {
            try realm.write(){
                let todaysTrackingData = TrackingDayDBT()
                todaysTrackingData.DateCreated = date
                realm.add(todaysTrackingData)
            }
        } catch {
            print("Error saving TrackingDay: \(error)")
        }
        updateAllStatus()
    }
    
    func checkToNotify(oldPercent: Int) {
        updateCompleteStatus()
        if oldPercent < 100 && getPercentageComplete() >= 100 {
            notify(module: module)
        }
    }
    
    private func notify(module: Modules) {
        NotificationCenter.default.post(name: .didCompleteModule, object: module)
    }
    
    func updateAllStatus() {
        FoodRatingDBS().updateCompleteStatus()
        Omega3HistoryDBS().updateCompleteStatus()
        VitaminDHistoryDBS().updateCompleteStatus()
        ExerciseHistoryDBS().updateCompleteStatus()
        MeditationHistoryDBS().updateCompleteStatus()
        SavedMedicationDBS().updateCompleteStatus()
    }
    
    //TODO: there will be a bug when the user changes their goals
    //make sure to update the complete status of the module when the user changes goals
    func updateCompleteStatus() {
        let day = getTrackingDay()
        do {
            try realm.write() {
                day.IsDayComplete = day.FoodEatenRating >= ProgressBarConfig.foodRatingGoals && day.IsOmega3Complete && day.IsVitaminDComplete && day.IsExerciseComplete && day.IsMeditationComplete && day.IsMedicationComplete
                
//                print("Food Complete: \(day.IsFoodComplete)")
//                print("Omega3 Complete: \(day.IsOmega3Complete)")
//                print("VitaminD Complete: \(day.IsVitaminDComplete)")
//                print("Exercise Complete: \(day.IsExerciseComplete)")
//                print("Meditation Complete: \(day.IsMeditationComplete)")
//                print("Medication Complete: \(day.IsMedicationComplete)")
//                print("Day Complete: \(day.IsDayComplete)")
            }
        } catch {
            print("Error updating complete status data: \(error)")
        }
    }
    
    func deleteItem(item: Object) {
        do {
            try realm.write() {
                realm.delete(item)
            }
        } catch {
            print("Error deleting data: \(error)")
        }
        updateCompleteStatus()
    }
    
    //MARK: Abstract Methods
    
    func addQuickCompleteItem() {
        fatalError("toggleFilledData not overriden")
    }
    
    func addItem(item: Object) {
        fatalError("addItem not overriden")
    }
    
    func getPercentageComplete() -> Int {
        fatalError("getPercentageComplete not overriden")
    }
    
    func getTrackingDescription() -> String {
        fatalError("getTrackingDescription not overriden")
    }
}
