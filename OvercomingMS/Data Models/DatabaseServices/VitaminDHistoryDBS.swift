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
    
    func toggleFilledData() {
        let percent = getPercentageComplete()
        let date = globalCurrentDate
        do {
            try realm.write() {
                let day = getTrackingDay(date: date)
                day.IsVitaminDComplete = !day.IsVitaminDComplete
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .VitaminD)
        }
    }
    
    func addVitaminDItem(vitaminDType: String, startTime: Date, vitaminDAmount: Int) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                let day = getTrackingDay(date: globalCurrentDate)
                let item = VitaminDHistoryDBT()
                item.VitaminDType = vitaminDType
                item.StartTime = startTime
                item.Amount = vitaminDAmount
                day.vitaminDHistoryDT.append(item)
            }
        } catch {
            print("Error updating Vitamin D data : \(error)" )
        }
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .VitaminD)
        }
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
    
    func deleteVitaminDItem(item: VitaminDHistoryDBT) {
        do {
            try realm.write() {
                realm.delete(item)
            }
        } catch {
            print("Error update Vitamin D data: \(error)")
        }
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
        if percent < 100 && getPercentageComplete() >= 100 {
            notify(module: .VitaminD)
        }
    }
    
}
