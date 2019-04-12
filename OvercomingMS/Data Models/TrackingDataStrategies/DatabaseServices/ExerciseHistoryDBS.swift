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
    
    func toggleFilledData() {
        let percent = getPercentageComplete()
        let date = globalCurrentDate
        do {
            try realm.write() {
                let day = getTrackingDay(date: date)
                day.IsExerciseComplete = !day.IsExerciseComplete
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .Exercise)
        }
    }
    
    func addExerciseItem(routineType: String, startTime: Date, endTime: Date) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                let day = getTrackingDay(date: globalCurrentDate)
                let item = ExerciseHistoryDBT()
                item.RoutineType = routineType
                item.StartTime = startTime
                item.EndTime = endTime
                day.exerciseHistoryDT.append(item)
            }
        } catch {
            print("Error updating Exercise data : \(error)" )
        }
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .Exercise)
        }
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
    
    func deleteExerciseItem(item: ExerciseHistoryDBT) {
        do {
            try realm.write() {
                realm.delete(item)
            }
        } catch {
            print("Error update Exercise data: \(error)")
        }
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
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .Exercise)
        }
    }

}
