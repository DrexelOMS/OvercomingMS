//
//  AbstractDBS.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class TrackingModulesDBS{
    
    let realm = try! Realm()
    lazy var trackingDays: Results<TrackingDayDBT> = { self.realm.objects(TrackingDayDBT.self) }()
    
    func getTrackingDay(date: String = globalCurrentDate) -> TrackingDayDBT? {
        return realm.object(ofType: TrackingDayDBT.self, forPrimaryKey: date)
    }
    
    func toggleFilledData(date : String = globalCurrentDate){
        fatalError("Abstract Method")
    }
    
}
