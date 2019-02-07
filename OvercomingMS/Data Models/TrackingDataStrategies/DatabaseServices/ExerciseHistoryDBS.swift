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
        let date = globalCurrentDate
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    day.IsExerciseComplete = !day.IsExerciseComplete
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func addExerciseItem(routineType: String, startTime: Date, endTime: Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: globalCurrentDate) {
                    let item = ExerciseHistoryDBT()
                    item.RoutineType = routineType
                    item.StartTime = startTime
                    item.EndTime = endTime
                    day.exerciseHistoryDT.append(item)
                }
            }
        } catch {
            print("Error updating Exercise data : \(error)" )
        }
        
    }
    
    func getTodaysExerciseItems() -> List<ExerciseHistoryDBT>? {
        return getTrackingDay()?.exerciseHistoryDT
    }
    
    func getTotalMinutes() -> Int {
        return getTrackingDay()?.ExerciseTimeTotal ?? 0
    }
    
    func getPercentageComplete() -> Int {
        return getTrackingDay()?.ExerciseComputedPercentageComplete ?? 0
    }

}
