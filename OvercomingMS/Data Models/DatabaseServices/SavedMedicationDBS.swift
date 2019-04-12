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
    
    override var module: Modules{
        get {
            return .Medication
        }
    }
    
    //TODO: not currently correct
    override func toggleFilledData() {
        let percent = getPercentageComplete()
        let date = globalCurrentDate
        do {
            try realm.write() {
                let day = getTrackingDay(date: date)
                day.IsMedicationComplete = !day.IsMedicationComplete
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
                realm.add(SavedMedicationDBT(value: item))
            }
        } catch {
            print("Error updating Medication data : \(error)" )
        }
        checkToNotify(oldPercent: percent)
    }

    //TODO: we need a better way to delete items
//get all the saved medications
    func getSavedMedicationItems() -> DisplayedMedicationItems {
        let trackedMeds: List<SavedMedicationDBT> = List<SavedMedicationDBT>()
        let untrackedMeds: List<SavedMedicationDBT> = List<SavedMedicationDBT>()
        let da = OMSDateAccessor()
        for med in realm.objects(SavedMedicationDBT.self) {
            if let deleteDate = med.DateDeleted {
                if da.greaterThanEqualComparison(left: globalCurrentFullDate, right: deleteDate) {
                    continue
                }
            }
            if da.lessThanComparison(left: globalCurrentFullDate, right: med.DateCreated) {
                continue
            }
            
            if isTrackedToday(item: med) {
                trackedMeds.append(med)
            }
            else {
                untrackedMeds.append(med)
            }
            
        }
        return DisplayedMedicationItems(trackedMeds: trackedMeds, untrackedMeds: untrackedMeds)
    }

    func updateSavedMedicationItem(oldItem: SavedMedicationDBT, newItem: SavedMedicationDBT) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
                oldItem.MedicationName = newItem.MedicationName
                oldItem.TimeOfDay = newItem.TimeOfDay
                oldItem.MedicationNote = newItem.MedicationNote
                oldItem.Frequency = newItem.Frequency
            }
        } catch {
            print("Error update SavedMedication data: \(error)")
        }
        checkToNotify(oldPercent: percent)
    }
    
    override func deleteItem(item: Object) {
        do {
            try realm.write() {
                SavedMedicationDBT(value: item).DateDeleted = OMSDateAccessor.getFullDate(date: getTrackingDay().DateCreated)
            }
        } catch {
            print("Error delete SavedMedication data: \(error)")
        }
    }
    
    func addTakenMedication(item: SavedMedicationDBT) {
        let percent = getPercentageComplete()
        do {
            try realm.write() {
               getTrackingDay().savedMedicationDT.append(item)
            }
        } catch {
            print("Error delete SavedMedication data: \(error)")
        }
        checkToNotify(oldPercent: percent)
    }
    
    func removeTakenMedication(item: SavedMedicationDBT) {
        do {
            try realm.write() {
                if let index = getTrackingDay().savedMedicationDT.index(of: item) {
                    getTrackingDay().savedMedicationDT.remove(at: index)
                }
            }
        } catch {
            print("Error delete SavedMedication data: \(error)")
        }
    }
    
    func wasTaken(item: SavedMedicationDBT) -> Bool {
        if getTrackingDay().savedMedicationDT.index(of: item) != nil{
            return true
        }
        return false
    }
    
    func isTrackedToday(item: SavedMedicationDBT) -> Bool {
        return item.Frequency.contains(OMSDateAccessor.getDayOfWeekLetter(globalCurrentDate))
    }
    
    
    //Get the tracked meds goals
    func getTodaysTotalMedGoal() -> Int {
        let meds = getSavedMedicationItems()

        return meds.medicationsTracked.count
    }
    
    override func getPercentageComplete() -> Int {
        return getTrackingDay().MedicationComputedPercentageComplete
    }
    
    override func getTrackingDescription() -> String {
        var description = ""
        let amountRemaining = getTodaysTotalMedGoal() - getTrackingDay().MedicationTotal
        let uom = "sets of meds"
        if(amountRemaining <= 0 || getPercentageComplete() >= 100){
            description = "Daily goal reached!"
        }
        else {
            description = "\(amountRemaining) \(uom) left"
        }
        return description
    }


}
