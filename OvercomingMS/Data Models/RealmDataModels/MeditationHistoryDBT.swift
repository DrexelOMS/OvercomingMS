//
//  MeditationHistoryDBT.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation

import RealmSwift

class MeditationHistoryDBT: Object {
    @objc dynamic var MeditationType : String = ""
    @objc dynamic var StartTime : Date = Date()
    @objc dynamic var EndTime : Date = Date()
    var minutes : Int {
        return EndTime.minutes(from: StartTime)
    }
    var parentDay = LinkingObjects(fromType: TrackingDayDBT.self, property: "meditationHistoryDT")
    
}
