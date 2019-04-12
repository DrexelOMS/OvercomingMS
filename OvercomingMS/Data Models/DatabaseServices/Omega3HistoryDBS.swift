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
    
    func toggleFilledData() {
        let percent = getPercentageComplete()
        let date = globalCurrentDate
        do {
            try realm.write() {
                let day = getTrackingDay(date: date)
                day.IsOmega3Complete = !day.IsOmega3Complete
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .Omega3)
        }
    }
    
    func addOmega3Item(supplementName: String, StartTime: Date, Amount: Int) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                let day = getTrackingDay(date: globalCurrentDate)
                let item = Omega3HistoryDBT()
                item.supplementName = supplementName
                item.StartTime = StartTime
                item.Amount = Amount
                day.omega3HistoryDT.append(item)
            }
        } catch {
            print("Error updating Omega3 data : \(error)" )
        }
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .Omega3)
        }
    }
    
    func getTodaysOmega3Items() -> List<Omega3HistoryDBT>? {
        return getTrackingDay().omega3HistoryDT
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
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) \(uom) left"
        }
        return description
    }
    
    func deleteOmega3Item(item: Omega3HistoryDBT) {
        do {
            try realm.write() {
                realm.delete(item)
            }
        } catch {
            print("Error update Omega3 data: \(error)")
        }
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
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .Omega3)
        }
    }
    
}
