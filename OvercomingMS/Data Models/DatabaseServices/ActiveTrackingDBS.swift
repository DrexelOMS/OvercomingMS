//
//  ActiveTrackingDBS.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/19/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class ActiveTrackingDBS {

    let realm = try! Realm()
    
    var foodIsActive: Bool?
    var omega3IsActive: Bool?
    var vitaminDIsActive: Bool?
    var exerciseIsActive: Bool?
    var meditationIsActive: Bool?
    var medicationIsActive: Bool?
    
    init() {
        if activeTracking.count <= 0 {
            initialize()
        }
    }
    
    private var activeTracking: [ActiveTrackingDBT] {
        get {
            let results: Results<ActiveTrackingDBT> = realm.objects(ActiveTrackingDBT.self)
            let converted = results.reduce(List<ActiveTrackingDBT>()) { (list, element) -> List<ActiveTrackingDBT> in
                list.append(element)
                return list
            }
            let sortedList = converted.sorted(by: { $0.DateModified < $1.DateModified })
            return sortedList
        }
    }
    
    var mostRecentActiveTracking: ActiveTrackingDBT {
        get {
            let currentDate = globalCurrentFullDate
            let da = OMSDateAccessor()
            
            var itemToReturn: ActiveTrackingDBT = activeTracking[activeTracking.count - 1]
            for item in activeTracking.reversed() {
                let date = OMSDateAccessor.getFullDate(date: item.DateModified)
                if da.greaterThanEqualComparison(left: currentDate, right: date) {
                    return item
                }
                itemToReturn = item
            }
            return itemToReturn
        }
    }
    
    func writeActiveItems() {
        let mostRecent = mostRecentActiveTracking
        do {
            try realm.write() {
                
                if globalCurrentDate != mostRecent.DateModified {
                    let item = ActiveTrackingDBT()
                    item.DateModified = globalCurrentDate
                    
                    item.IsFoodActive = foodIsActive ?? mostRecent.IsFoodActive
                    item.IsOmega3Active = omega3IsActive ?? mostRecent.IsOmega3Active
                    item.IsVitaminDActive = vitaminDIsActive ?? mostRecent.IsVitaminDActive
                    item.IsExerciseActive = exerciseIsActive ?? mostRecent.IsExerciseActive
                    item.IsMeditationActive = meditationIsActive ?? mostRecent.IsMeditationActive
                    item.IsMedicationActive = medicationIsActive ?? mostRecent.IsMedicationActive
                    
                    realm.add(item)
                }
                else {
                    let item = mostRecent
                    
                    item.IsFoodActive = foodIsActive ?? mostRecent.IsFoodActive
                    item.IsOmega3Active = omega3IsActive ?? mostRecent.IsOmega3Active
                    item.IsVitaminDActive = vitaminDIsActive ?? mostRecent.IsVitaminDActive
                    item.IsExerciseActive = exerciseIsActive ?? mostRecent.IsExerciseActive
                    item.IsMeditationActive = meditationIsActive ?? mostRecent.IsMeditationActive
                    item.IsMedicationActive = medicationIsActive ?? mostRecent.IsMedicationActive
                    
                }
            }
        }
        catch {
            print("Error updating food data : \(error)" )
        }
        
        TrackingModulesDBS().updateAllStatus()
    }
    
    private func initialize() {
        do {
            try realm.write() {
                let item = ActiveTrackingDBT()
                item.DateModified = globalCurrentDate
                realm.add(item)
            }
        }
        catch {
            print("Error updating food data : \(error)" )
        }
    }

}
