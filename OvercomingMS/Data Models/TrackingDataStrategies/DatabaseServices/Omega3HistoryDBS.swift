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
        let date = globalCurrentDate
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    day.IsOmega3Complete = !day.IsOmega3Complete
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func addOmega3Item(supplementName: String, StartTime: Date, Amount: Int) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: globalCurrentDate) {
                    let item = Omega3HistoryDBT()
                    item.supplementName = supplementName
                    item.StartTime = StartTime
                    item.Amount = Amount
                    day.omega3HistoryDT.append(item)
                }
            }
        } catch {
            print("Error updating Omega3 data : \(error)" )
        }
        
    }
    
    func getTodaysOmega3Items() -> List<Omega3HistoryDBT>? {
        return getTrackingDay()?.omega3HistoryDT
    }
    
    func getTotalGrams() -> Int {
        return getTrackingDay()?.Omega3Total ?? 0
    }
    
    func getPercentageComplete() -> Int {
        return getTrackingDay()?.Omega3ComputedPercentageComplete ?? 0
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
        do {
            try realm.write() {
                oldItem.supplementName = newItem.supplementName
                oldItem.StartTime = newItem.StartTime
                oldItem.Amount = newItem.Amount
            }
        } catch {
            print("Error update Omega3 data: \(error)")
        }
    }
    
}
