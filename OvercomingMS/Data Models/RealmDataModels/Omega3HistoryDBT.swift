//
//  Omega3HistoryDBT.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/12/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class Omega3HistoryDBT: Object {
    @objc dynamic var supplementName : String = ""
    @objc dynamic var StartTime : Date = Date()
    @objc dynamic var Amount : Int = 0

    var parentDay = LinkingObjects(fromType: TrackingDayDBT.self, property: "omega3HistoryDT")
    
}
