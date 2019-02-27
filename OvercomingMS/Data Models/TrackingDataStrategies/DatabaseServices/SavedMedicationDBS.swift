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
    
    //TODO: not currently correct
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
    
    func addMedicationItem(medicationName: String, timeOfDay: Date, medicationAmount: Int, medicationUOM: String, freq: String, active: Bool) {
        
        do {
            try realm.write() {
                let item = SavedMedicationDBT()
                
                item.MedicationName = medicationName
                item.TimeOfDay = timeOfDay
                item.MedicationAmount = medicationAmount
                item.MedicationUOM = medicationUOM
                item.Frequency = freq
                realm.add(item)
            }
        } catch {
            print("Error updating Medication data : \(error)" )
        }
        
    }

    //TODO: we need a better way to delete items
//get all the saved medications
    func getSavedMedicationItems() -> List<SavedMedicationDBT>? {
        let savedMeds: List<SavedMedicationDBT> = List<SavedMedicationDBT>()
        let da = OMSDateAccessor()
        for med in realm.objects(SavedMedicationDBT.self) {
            if let deleteDate = med.DateDeleted {
                if (da.greaterThanEqualComparison(dateToCompare: deleteDate)) {
                    continue
                }
            }
            savedMeds.append(med)
        }
        return savedMeds
    }

    func updateSavedMedicationItem(oldItem: SavedMedicationDBT, newItem: SavedMedicationDBT) {
        do {
            try realm.write() {
                oldItem.MedicationName = newItem.MedicationName
                oldItem.TimeOfDay = newItem.TimeOfDay
                oldItem.MedicationAmount = newItem.MedicationAmount
                oldItem.MedicationUOM = newItem.MedicationUOM
                oldItem.Frequency = newItem.Frequency
            }
        } catch {
            print("Error update SavedMedication data: \(error)")
        }
    }

//deleteSavedMedication() NOTE: do not copy the delete code, when you delete the medication, simply set active to true, and in the get all saved medications method, you need to go through all the medication items, making a new list, skipping any that have Active = false
    
    func deleteSavedMedication(item: SavedMedicationDBT) {
        do {
            try realm.write() {
                //item.Active = false
                item.DateDeleted = OMSDateAccessor.getFullDate(date: getTrackingDay()!.DateCreated) //more thought for tracking over time
            }
        } catch {
            print("Error delete SavedMedication data: \(error)")
        }
    }
    
    func addTakenMedication(item: SavedMedicationDBT) {
        do {
            try realm.write() {
               getTrackingDay()?.savedMedicationDT.append(item)
            }
        } catch {
            print("Error delete SavedMedication data: \(error)")
        }
    }
    
    func removeTakenMedication(item: SavedMedicationDBT) {
        do {
            try realm.write() {
                
                if let index = getTrackingDay()?.savedMedicationDT.index(of: item){
                    getTrackingDay()?.savedMedicationDT.remove(at: index)
                }

            }
        } catch {
            print("Error delete SavedMedication data: \(error)")
        }
    }
    
    func wasTaken(item: SavedMedicationDBT) -> Bool {
        if getTrackingDay()?.savedMedicationDT.index(of: item) != nil{
            return true
        }
        return false
    }
    
    func isTrackedToday(item: SavedMedicationDBT) -> Bool {
        return item.Frequency.contains(OMSDateAccessor.getDayOfWeekLetter(globalCurrentDate))
    }
    
    
    //TODO: this is not correct?
    func getTodaysTotalMedGoal() -> Int {
        var count = 0

        if let meds = getSavedMedicationItems(){
            let todaysLetter = OMSDateAccessor.getDayOfWeekLetter(globalCurrentDate)
            for med in meds {
                
                if med.Frequency.contains(todaysLetter) {
                    count += 1
                }
            }
        }
        return count
    }
    
    //TODO: this is not correct?
    func getPercentageComplete() -> Int {
        return getTrackingDay()?.MedicationComputedPercentageComplete ?? 0
    }


}
