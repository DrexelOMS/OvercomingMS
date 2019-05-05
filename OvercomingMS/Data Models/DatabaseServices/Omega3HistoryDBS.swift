//
//  Omega3HistoryDBS.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/12/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class Omega3HistoryDBS: TrackingModulesDBS {
    
    override var module: Modules {
        get {
            return .Omega3
        }
    }
    
    override func updateCompleteStatus() {
        do {
            try realm.write() {
                getTrackingDay().IsOmega3Complete = getPercentageComplete() >= 100
            }
        } catch {
            print("Error updating Omega3 data : \(error)" )
        }
        
        super.updateCompleteStatus()
    }
    
    override func addQuickCompleteItem() {
        let remaining = ProgressBarConfig.omega3Goal - getTrackingDay().Omega3Total
        if remaining > 0 {
            let quickItem = Omega3HistoryDBT()
            let startTime = Date()
            
            quickItem.supplementName = QUICK_COMPLETE
            quickItem.StartTime = startTime
            quickItem.Amount = remaining
            
            addItem(item: quickItem)
        }
    }
    
    override func addItem(item: Object) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                getTrackingDay().omega3HistoryDT.append(Omega3HistoryDBT(value: item))
            }
        } catch {
            print("Error updating Omega3 data : \(error)" )
        }
        checkToNotify(oldPercent: percent)
    }
    
    func getTodaysOmega3Items() -> [Omega3HistoryDBT]? {
        let converted = getTrackingDay().omega3HistoryDT
        let sortedList = converted.sorted(by: { $0.StartTime < $1.StartTime })
        return sortedList
    }
    
    func getTotalGrams() -> Int {
        return getTrackingDay().Omega3Total
    }
    
    override func getPercentageComplete() -> Int {
        return getTrackingDay().Omega3ComputedPercentageComplete
    }
    
    override func getTrackingDescription() -> String {
        var description = ""
        let amountRemaining = ProgressBarConfig.omega3Goal - getTotalGrams()
        let uom = ProgressBarConfig.omega3UOM
        if(amountRemaining <= 0 || getPercentageComplete() >= 100){
            description = "Goal reached!"
        }
        else {
            description = "\(amountRemaining) grams left"
        }
        return description
    }
    
    func updateOmega3Item(oldItem: Omega3HistoryDBT, newItem: Omega3HistoryDBT) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                oldItem.supplementName = newItem.supplementName
                oldItem.StartTime = newItem.StartTime
                oldItem.Amount = newItem.Amount
            }
        } catch {
            print("Error update Omega3 data: \(error)")
        }
        checkToNotify(oldPercent: percent)
    }
    
}
