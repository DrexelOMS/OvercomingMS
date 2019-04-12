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
    
    override func toggleFilledData() {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                getTrackingDay().IsOmega3Complete = !getTrackingDay().IsOmega3Complete
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
                getTrackingDay().omega3HistoryDT.append(Omega3HistoryDBT(value: item))
            }
        } catch {
            print("Error updating Omega3 data : \(error)" )
        }
        checkToNotify(oldPercent: percent)
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
