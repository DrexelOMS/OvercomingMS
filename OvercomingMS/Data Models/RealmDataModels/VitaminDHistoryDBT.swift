//
//  VitaminDHistoryDBT.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/17/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class VitaminDHistoryDBT: Object {
    @objc dynamic var VitaminDType : String = ""
    @objc dynamic var Timestamp : Date = Date()
    @objc dynamic var VitaminDAmount : Int = 0
    
    var parentDay = LinkingObjects(fromType: TrackingDayDBT.self, property: "vitaminDHistoryDT")
}
