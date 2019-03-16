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
    
    func getTrackingDay(date: String = globalCurrentDate) -> TrackingDayDBT? {
        return realm.object(ofType: TrackingDayDBT.self, forPrimaryKey: date)
    }
    
    func notify(module: Modules) {
        //NotificationCenter.default.post(name: .didCompleteModule, object: module, userInfo: ["Module": module])
        NotificationCenter.default.post(name: .didCompleteModule, object: module)
    }
    
}
