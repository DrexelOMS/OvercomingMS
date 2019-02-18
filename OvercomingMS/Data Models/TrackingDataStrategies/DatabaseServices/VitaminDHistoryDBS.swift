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
        let date = globalCurrentDate
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    day.IsVitaminDComplete = !day.IsVitaminDComplete
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func addVitaminDSupplementItem(vitaminDType: String, startTime: Date, vitaminDAmount: Int) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: globalCurrentDate) {
                    let item = VitaminDHistoryDBT()
                    item.VitaminDType = vitaminDType
                    item.StartTime = startTime
                    item.Amount = vitaminDAmount
                    day.vitaminDHistoryDT.append(item)
                }
            }
        } catch {
            print("Error updating Vitamin D data : \(error)" )
        }
        
    }
    
    func addVitaminDOutsideItem(vitaminDType: String, startTime: Date, endTime: Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: globalCurrentDate) {
                    let item = VitaminDHistoryDBT()
                    item.IsOutsideType = true
                    item.VitaminDType = vitaminDType
                    item.StartTime = startTime
                    item.EndTime = endTime
                    day.vitaminDHistoryDT.append(item)
                }
            }
        } catch {
            print("Error updating Vitamin D data : \(error)" )
        }
        
    }
    
    func getTodaysVitaminDItems() -> List<VitaminDHistoryDBT>? {
        return getTrackingDay()?.vitaminDHistoryDT
    }
    
    func getTotalAmount() -> Int {
        return getTrackingDay()?.VitaminDTotal ?? 0
    }
    
    func getPercentageComplete() -> Int {
        return getTrackingDay()?.VitaminDComputedPercentageComplete ?? 0
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
        do {
            try realm.write() {
                oldItem.VitaminDType = newItem.VitaminDType
                oldItem.StartTime = newItem.StartTime
                oldItem.Amount = newItem.Amount
            }
        } catch {
            print("Error update Vitamin D data: \(error)")
        }
    }
    
}
