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
    @objc dynamic var DateCreated : Date = Date()
    
    var parentDay = LinkingObjects(fromType: TrackingDayDBT.self, property: "symptomsNoteDT")

}


