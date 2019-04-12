//
//  AbstractDBS.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

enum Modules {
    case Food,
    Omega3,
    VitaminD,
    Exercise,
    Meditation,
    Medication
}

class TrackingModulesDBS{
    
    let realm = try! Realm()
    
    var module : Modules {
        get {
            fatalError("forgot to Override Module")
        }
    }

    func getTrackingDay(date: String = globalCurrentDate) -> TrackingDayDBT {
        if let trackingDay = realm.object(ofType: TrackingDayDBT.self, forPrimaryKey: date) {
            return trackingDay
        }
        else {
            initializeTodaysData(date: date)
            return getTrackingDay(date: date)
        }
    }
    
    private func initializeTodaysData(date : String) {
        do {
            try realm.write(){
                let todaysTrackingData = TrackingDayDBT()
                todaysTrackingData.DateCreated = date
                realm.add(todaysTrackingData)
            }
        } catch {
            print("Error saving TrackingDay: \(error)")
        }
    }
    
    func checkToNotify(oldPercent: Int) {
        if oldPercent < 100 && getPercentageComplete() >= 100 {
            notify(module: module)
        }
    }
    
    private func notify(module: Modules) {
        NotificationCenter.default.post(name: .didCompleteModule, object: module)
    }
    
    //MARK: Abstract Methods
    
    func toggleFilledData() {
        fatalError("toggleFilledData not overriden")
    }
    
    func addItem(item: Object) {
        fatalError("addItem not overriden")
    }
    
    func deleteItem(item: Object) {
        do {
            try realm.write() {
                realm.delete(item)
            }
        } catch {
            print("Error deleting data: \(error)")
        }
    }
    
    func getPercentageComplete() -> Int {
        fatalError("getPercentageComplete not overriden")
    }
    
    func getTrackingDescription() -> String {
        fatalError("getTrackingDescription not overriden")
    }
}
