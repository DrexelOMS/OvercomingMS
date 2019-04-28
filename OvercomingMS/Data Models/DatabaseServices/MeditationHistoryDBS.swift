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

    override func updateCompleteStatus() {
        do {
            try realm.write() {
                getTrackingDay().IsMeditationComplete = getPercentageComplete() >= 100
            }
        } catch {
            print("Error updating Meditation data : \(error)" )
        }
        
        super.updateCompleteStatus()
    }
    
    override func addQuickCompleteItem() {
        let remaining = ProgressBarConfig.meditationGoal - getTrackingDay().MeditationTimeTotal
        if remaining > 0 {
            let quickItem = MeditationHistoryDBT()
            let startTime = Date()
            
            quickItem.MeditationType = QUICK_COMPLETE
            quickItem.StartTime = startTime
            quickItem.EndTime = startTime.addingTimeInterval(TimeInterval(remaining * 60))
            
            addItem(item: quickItem)
        }
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
    
    func getTodaysMeditationItems() -> [MeditationHistoryDBT]? {
        let converted = getTrackingDay().meditationHistoryDT
        let sortedList = converted.sorted(by: { $0.StartTime < $1.StartTime })
        return sortedList
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
