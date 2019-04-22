//
//  SymptomsNoteDBT.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/28/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift


class SymptomsNoteDBT: Object {
    @objc dynamic var Note : String = ""
    @objc dynamic var DateCreated : String = ""
    @objc dynamic var TimeOfDay : Date = Date() // rename this to time created
    @objc dynamic var SymptomsRating: Int = 1 // rate from 1-5
    
    var parentDay = LinkingObjects(fromType: TrackingDayDBT.self, property: "symptomsNoteDT")

}


