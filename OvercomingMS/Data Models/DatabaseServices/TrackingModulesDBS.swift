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
    case Omega3,
    VitaminD,
    Exercise,
    Meditation,
    Medication
}

class TrackingModulesDBS{
    
    let realm = try! Realm()
    lazy var trackingDays: Results<TrackingDayDBT> = { self.realm.objects(TrackingDayDBT.self) }()
    
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

    func notify(module: Modules) {
        //NotificationCenter.default.post(name: .didCompleteModule, object: module, userInfo: ["Module": module])
        NotificationCenter.default.post(name: .didCompleteModule, object: module)
    }
    
    func getPercentageComplete() -> Int {
        fatalError("getPercentageComplete not overriden")
    }
    
    func getTrackingDescription() -> String {
        fatalError("getTrackingDescription not overriden")
    }
}
