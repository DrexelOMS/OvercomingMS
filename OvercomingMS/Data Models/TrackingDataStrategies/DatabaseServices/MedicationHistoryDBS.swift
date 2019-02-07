//
//  MedicationHistoryDBS.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class MedicationHistoryDBS: TrackingModulesDBS {
    
    func toggleFilledData() {
        let date = globalCurrentDate
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    day.IsMedicationComplete = !day.IsMedicationComplete
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func addMedicationItem(medicationName: String, time: Date, medicationAmount: Int, medicationUOM: String, freq: String) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: globalCurrentDate) {
                    let item = MedicationHistoryDBT()
                    
                    item.MedicationName = medicationName
                    item.Time = time
                    item.MedicationAmount = medicationAmount
                    item.MedicationUOM = medicationUOM
                    item.Freq = freq
                    
                    day.medicationHistoryDT.append(item)
                }
            }
        } catch {
            print("Error updating Medication data : \(error)" )
        }
        
    }
    
    func getTodaysMedicationItems() -> List<MedicationHistoryDBT>? {
        return getTrackingDay()?.medicationHistoryDT
    }
    
    func getTotalMeds() -> Int {
        return getTrackingDay()?.MedicationTotal ?? 0
    }
    
    func getPercentageComplete() -> Int {
        return getTrackingDay()?.MedicationComputedPercentageComplete ?? 0
    }
}
