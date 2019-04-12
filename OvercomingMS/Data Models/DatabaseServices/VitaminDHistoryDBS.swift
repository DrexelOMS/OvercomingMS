//
//  VitaminDHistoryDBS.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/18/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class VitaminDHistoryDBS: TrackingModulesDBS {
    
    override var module: Modules {
        get {
            return .VitaminD
        }
    }
    
    override func toggleFilledData() {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                getTrackingDay().IsVitaminDComplete = !getTrackingDay().IsVitaminDComplete
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
                getTrackingDay().vitaminDHistoryDT.append(VitaminDHistoryDBT(value: item))
            }
        } catch {
            print("Error updating Vitamin D data : \(error)" )
        }
        checkToNotify(oldPercent: percent)
    }
    
    func getTodaysVitaminDItems() -> List<VitaminDHistoryDBT>? {
        return getTrackingDay().vitaminDHistoryDT
    }
    
    func getTotalAmount() -> Int {
        return getTrackingDay().VitaminDTotal
    }
    
    override func getPercentageComplete() -> Int {
        return getTrackingDay().VitaminDComputedPercentageComplete
    }
    
    override func getTrackingDescription() -> String {
        var description = ""
        let amountRemaining = ProgressBarConfig.vitaminDGoal - getTotalAmount()
        let uom = ProgressBarConfig.vitaminDUOM
        if(amountRemaining <= 0 || getPercentageComplete() >= 100){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) \(uom) left"
        }
        return description
    }
    
    func updateVitaminDItem(oldItem: VitaminDHistoryDBT, newItem: VitaminDHistoryDBT) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                oldItem.VitaminDType = newItem.VitaminDType
                oldItem.StartTime = newItem.StartTime
                oldItem.Amount = newItem.Amount
            }
        } catch {
            print("Error update Vitamin D data: \(error)")
        }
        checkToNotify(oldPercent: percent)
    }
    
}
