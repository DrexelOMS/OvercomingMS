//
//  SavedMedicationDBT.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class SavedMedicationDBT: Object {
    @objc dynamic var MedicationName : String = ""
    @objc dynamic var DateCreated : Date = Date()
    @objc dynamic var TimeOfDay : Date = Date()
    @objc dynamic var MedicationNote : String = ""
    @objc dynamic var Frequency : String = "" //Conversion is MTWRFSU, U is sunday
    @objc dynamic var DateDeleted: Date? = nil
}
