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
    
    //Note that IsOutsideType and EndTime are not always set
    
    @objc dynamic var IsOutsideType : Bool = false
    @objc dynamic var VitaminDType : String = ""
    @objc dynamic var StartTime : Date = Date()
    @objc dynamic var EndTime : Date = Date()
    @objc dynamic var VitaminDAmount : Int = 0
    
    var parentDay = LinkingObjects(fromType: TrackingDayDBT.self, property: "vitaminDHistoryDT")
}
