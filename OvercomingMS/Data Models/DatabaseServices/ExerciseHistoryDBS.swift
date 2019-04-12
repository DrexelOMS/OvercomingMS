//
//  ExerciseRoutinesDBS.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class ExerciseHistoryDBS: TrackingModulesDBS {
    
    override var module: Modules {
        get {
            return .Exercise
        }
    }
    
    override func toggleFilledData() {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                getTrackingDay().IsExerciseComplete = !getTrackingDay().IsExerciseComplete
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        checkToNotify(oldPercent: percent)
    }
    
    override func addItem(item: Object) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                getTrackingDay().exerciseHistoryDT.append(ExerciseHistoryDBT(value: item))
            }
        } catch {
            print("Error updating Exercise data : \(error)" )
        }
        checkToNotify(oldPercent: percent)
    }
    
    func getTodaysExerciseItems() -> List<ExerciseHistoryDBT>? {
        return getTrackingDay().exerciseHistoryDT
    }
    
    func getTotalMinutes() -> Int {
        return getTrackingDay().ExerciseTimeTotal
    }
    
    override func getPercentageComplete() -> Int {
        return getTrackingDay().ExerciseComputedPercentageComplete
    }
    
    override func getTrackingDescription() -> String {
        var description = ""
        let amountRemaining = ProgressBarConfig.exerciseGoal - getTotalMinutes()
        let uom = ProgressBarConfig.lengthUOM
        if(amountRemaining <= 0 || getPercentageComplete() >= 100){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) \(uom) left"
        }
        return description
    }
    
    func updateExerciseItem(oldItem: ExerciseHistoryDBT, newItem: ExerciseHistoryDBT) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                oldItem.RoutineType = newItem.RoutineType
                oldItem.StartTime = newItem.StartTime
                oldItem.EndTime = newItem.EndTime
            }
        } catch {
            print("Error update Exercise data: \(error)")
        }
        checkToNotify(oldPercent: percent)
    }

}