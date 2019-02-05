//
//  ExerciseRoutinesDBS.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class ExerciseRoutinesDBS: TrackingModulesDBS {
        
    func toggleFilledData() {
        let date = globalCurrentDate
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    if day.ExercisePercentageComplete != 100 {
                        day.ExercisePercentageComplete = 100
                    }
                    else {
                        var percentage = Float(day.ExerciseTimeTotal) / Float(ProgressBarConfig.exerciseGoal) * 100
                        if percentage > 100 {
                            percentage = 100
                        }
                        day.ExercisePercentageComplete = Int(percentage)
                    }
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
                    let item = ExerciseRoutinesDBT()
                    item.RoutineType = routineType
                    item.StartTime = startTime
                    item.EndTime = endTime
                    day.exerciseRoutinesDT.append(item)
                }
            }
        } catch {
            print("Error updating Exercise data : \(error)" )
        }
        
    }
    
    func getTodaysExerciseItems() -> List<ExerciseRoutinesDBT>? {
        return getTrackingDay()?.exerciseRoutinesDT
    }
    
    func getTotalMinutes() -> Int {
        return getTrackingDay()?.ExerciseTimeTotal ?? 0
    }
    
    func getPercentageComplete() -> Int {
        return getTrackingDay()?.ExerciseComputedPercentageComplete ?? 0
    }

}
