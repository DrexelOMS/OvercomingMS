//
//  ExerciseRoutinesDT.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation

import RealmSwift

class ExerciseRoutinesDBT: Object {
    @objc dynamic var RoutineType : String = ""
    @objc dynamic var StartTime : Date = Date()
    @objc dynamic var EndTime : Date = Date()
    var minutes : Int {
        return EndTime.minutes(from: StartTime)
    }
    var parentDay = LinkingObjects(fromType: TrackingDayDBT.self, property: "exerciseRoutinesDT")
}
