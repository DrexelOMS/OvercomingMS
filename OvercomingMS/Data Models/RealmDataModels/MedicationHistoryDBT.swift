//
//  MedicationHistoryDBT.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class MedicationHistoryDBT: Object {
    @objc dynamic var MedicationName : String = ""
    @objc dynamic var Time : Date = Date()
    @objc dynamic var MedicationAmount : Int = 0
    @objc dynamic var MedicationUOM : String = ""
    @objc dynamic var Freq : String = ""
    
    
    var parentDay = LinkingObjects(fromType: TrackingDayDBT.self, property: "medicationHistoryDT")
}
