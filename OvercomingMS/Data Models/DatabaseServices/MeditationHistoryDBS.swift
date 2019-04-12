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
    
    override var module: Modules {
        get {
            return .Meditation
        }
    }
    override func toggleFilledData() {
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
        checkToNotify(oldPercent: percent)
    }
    
    override func addItem(item: Object) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                getTrackingDay().meditationHistoryDT.append(MeditationHistoryDBT(value: item))
            }
        } catch {
            print("Error updating Meditation data : \(error)" )
        }
        checkToNotify(oldPercent: percent)
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
        checkToNotify(oldPercent: percent)
    }
    
}
