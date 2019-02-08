//
//  MeditationHistoryDBS.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class MeditationHistoryDBS: TrackingModulesDBS {
    
    func toggleFilledData() {
        let date = globalCurrentDate
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    day.IsMeditationComplete = !day.IsMeditationComplete
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func addMeditationItem(routineType: String, startTime: Date, endTime: Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: globalCurrentDate) {
                    let item = MeditationHistoryDBT()
                    item.MeditationType = routineType
                    item.StartTime = startTime
                    item.EndTime = endTime
                    day.meditationHistoryDT.append(item)
                }
            }
        } catch {
            print("Error updating Meditation data : \(error)" )
        }
        
    }
    
    func getTodaysMeditationItems() -> List<MeditationHistoryDBT>? {
        return getTrackingDay()?.meditationHistoryDT
    }
    
    func getTotalMinutes() -> Int {
        return getTrackingDay()?.MeditationTimeTotal ?? 0
    }
    
    func getPercentageComplete() -> Int {
        return getTrackingDay()?.MeditationComputedPercentageComplete ?? 0
    }
    
    func deleteMeditationItem(item: MeditationHistoryDBT) {
        do {
            try realm.write() {
                realm.delete(item)
            }
        } catch {
            print("Error update Meditation data: \(error)")
        }
    }
    
    func updateExerciseItem(oldItem: MeditationHistoryDBT, newItem: MeditationHistoryDBT) {
        do {
            try realm.write() {
                oldItem.MeditationType = newItem.MeditationType
                oldItem.StartTime = newItem.StartTime
                oldItem.EndTime = newItem.EndTime
            }
        } catch {
            print("Error update Meditation data: \(error)")
        }
    }
    
}
