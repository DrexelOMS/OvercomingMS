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
        let percent = getPercentageComplete()
        let date = globalCurrentDate
        do {
            try realm.write() {
                let day = getTrackingDay(date: date)
                day.IsMeditationComplete = !day.IsMeditationComplete
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .Meditation)
        }
    }
    
    func addMeditationItem(routineType: String, startTime: Date, endTime: Date) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                let day = getTrackingDay(date: globalCurrentDate)
                let item = MeditationHistoryDBT()
                item.MeditationType = routineType
                item.StartTime = startTime
                item.EndTime = endTime
                day.meditationHistoryDT.append(item)
            }
        } catch {
            print("Error updating Meditation data : \(error)" )
        }
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .Meditation)
        }
    }
    
    func getTodaysMeditationItems() -> List<MeditationHistoryDBT>? {
        return getTrackingDay().meditationHistoryDT
    }
    
    func getTotalMinutes() -> Int {
        return getTrackingDay().MeditationTimeTotal
    }
    
    override func getPercentageComplete() -> Int {
        return getTrackingDay().MeditationComputedPercentageComplete
    }
    
    override func getTrackingDescription() -> String {
        var description = ""
        let amountRemaining = ProgressBarConfig.meditationGoal - getTotalMinutes()
        let uom = ProgressBarConfig.lengthUOM
        if(amountRemaining <= 0 || getPercentageComplete() >= 100){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) \(uom) left"
        }
        return description
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
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                oldItem.MeditationType = newItem.MeditationType
                oldItem.StartTime = newItem.StartTime
                oldItem.EndTime = newItem.EndTime
            }
        } catch {
            print("Error update Meditation data: \(error)")
        }
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .Meditation)
        }
    }
    
}
