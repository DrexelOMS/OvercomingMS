//
//  SavedMedicationDBS.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/21/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class SavedMedicationDBS: TrackingModulesDBS {
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
    
//needs a method to add a new medication
    func addMedicationItem(medicationName: String, timeOfDay: Date, medicationAmount: Int, medicationUOM: String, freq: String, active: Bool) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: globalCurrentDate) {
                    let item = SavedMedicationDBT()
                    
                    item.MedicationName = medicationName
                    item.TimeOfDay = timeOfDay
                    item.MedicationAmount = medicationAmount
                    item.MedicationUOM = medicationUOM
                    item.Frequency = freq
                    item.Active = active
                    day.savedMedicationDT.append(item)
                }
            }
        } catch {
            print("Error updating Medication data : \(error)" )
        }
        
    }

//get all the saved medications
    func getSavedMedicationItems() -> List<SavedMedicationDBT>? {
        return getTrackingDay()?.savedMedicationDT
    }

//update a saved medication,
    func updateSavedMedicationItem(oldItem: SavedMedicationDBT, newItem: SavedMedicationDBT) {
        do {
            try realm.write() {
                oldItem.MedicationName = newItem.MedicationName
                oldItem.TimeOfDay = newItem.TimeOfDay
                oldItem.MedicationAmount = newItem.MedicationAmount
                oldItem.MedicationUOM = newItem.MedicationUOM
                oldItem.Frequency = newItem.Frequency
                oldItem.Active = newItem.Active
            }
        } catch {
            print("Error update SavedMedication data: \(error)")
        }
    }

//deleteSavedMedication() NOTE: do not copy the delete code, when you delete the medication, simply set active to true, and in the get all saved medications method, you need to go through all the medication items, making a new list, skipping any that have Active = false
    
    func deleteSavedMedication(item: SavedMedicationDBT) {
        do {
            try realm.write() {
                item.Active = false
            }
        } catch {
            print("Error delete SavedMedication data: \(error)")
        }
    }
    
    
    
    func getTotalMeds() -> Int {
        return getTrackingDay()?.MedicationTotal ?? 0
    }
    
    func getPercentageComplete() -> Int {
        return getTrackingDay()?.MedicationComputedPercentageComplete ?? 0
    }


}
