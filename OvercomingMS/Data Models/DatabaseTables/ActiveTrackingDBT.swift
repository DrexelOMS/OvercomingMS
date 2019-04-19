//
//  ActiveTracking.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/19/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class ActiveTrackingDBT: Object {
    
    @objc dynamic var IsFoodActive : Bool = true
    @objc dynamic var IsOmega3Active : Bool = true
    @objc dynamic var IsVitaminDActive : Bool = true
    @objc dynamic var IsExerciseActive : Bool = true
    @objc dynamic var IsMeditationActive : Bool = true
    @objc dynamic var IsMedicationActive : Bool = true
    @objc dynamic var DateModified: String = ""
    
    override static func primaryKey() -> String? {
        return "DateModified"
    }
    
}
