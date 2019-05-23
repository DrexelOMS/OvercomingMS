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
    let defaults = UserDefaults.standard
    
    var notificationCenter = NotificationCenterWrapper()
    
    private var editingDate = globalCurrentDate
    
    convenience init(editingDate: String) {
        self.init()
        
        self.editingDate = editingDate
    }
    
    var module : Modules {
        get {
            fatalError("Forgot to override module")
        }
    }

    func getTrackingDay() -> TrackingDayDBT {
        if let trackingDay = realm.object(ofType: TrackingDayDBT.self, forPrimaryKey: editingDate) {
            return trackingDay
        }
        else {
            initializeTodaysData()
            return getTrackingDay()
        }
    }
    
    // only to be used by getTrackingDay
    private func initializeTodaysData() {
        do {
            try realm.write(){
                let todaysTrackingData = TrackingDayDBT()
                todaysTrackingData.DateCreated = editingDate
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
        notificationCenter.post(name: .didCompleteModule, object: module)
    }
    
    func updateAllStatus() {
        FoodRatingDBS(editingDate: editingDate).updateCompleteStatus()
        Omega3HistoryDBS(editingDate: editingDate).updateCompleteStatus()
        VitaminDHistoryDBS(editingDate: editingDate).updateCompleteStatus()
        ExerciseHistoryDBS(editingDate: editingDate).updateCompleteStatus()
        MeditationHistoryDBS(editingDate: editingDate).updateCompleteStatus()
        SavedMedicationDBS(editingDate: editingDate).updateCompleteStatus()
    }
    
    //TODO: there will be a bug when the user changes their goals
    //make sure to update the complete status of the module when the user changes goals
    func updateCompleteStatus() {
        let day = getTrackingDay()
        let savedIsDayComplete = day.IsDayComplete
        do {
            try realm.write() {
                day.IsDayComplete = day.IsFoodComplete && day.IsOmega3Complete && day.IsVitaminDComplete && day.IsExerciseComplete && day.IsMeditationComplete && day.IsMedicationComplete
            }
        } catch {
            print("Error updating complete status data: \(error)")
        }
 
        let isDayComplete = day.IsDayComplete
        if savedIsDayComplete != isDayComplete {
            let totalDays = getTotalPerfectDays()
            if isDayComplete {
                defaults.set(totalDays + 1, forKey: "TotalPerfectDays")
            }
            else {
                defaults.set(totalDays - 1, forKey: "TotalPerfectDays")
            }
        }
    }
    
    func getTotalPerfectDays() -> Int {
        return defaults.object(forKey: "TotalPerfectDays") as? Int ?? 0
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
