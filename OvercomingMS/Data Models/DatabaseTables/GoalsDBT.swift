//
//  GoalsDBT.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/8/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class GoalsDBT: Object {
    @objc dynamic var FoodRatingGoal : Int = 4 // 3 / 5 stars
    @objc dynamic var Omega3Goal : Int = 20
    @objc dynamic var VitaminDGoal : Int = 10
    @objc dynamic var ExerciseGoal : Int = 30
    @objc dynamic var MeditationGoal : Int = 15
    @objc dynamic var DateModified: String = ""
    
    override static func primaryKey() -> String? {
        return "DateModified"
    }

}
