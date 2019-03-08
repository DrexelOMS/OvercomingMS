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
    @objc dynamic var FoodRatingGoal : Int = 3 // 3 / 5 stars
    @objc dynamic var Omega3Goal : Int = 100
    @objc dynamic var VitaminDGoal : Int = 100
    @objc dynamic var ExerciseGoal : Int = 30
    @objc dynamic var MeditationGoal : Int = 30
    @objc dynamic var DateModified: Date = Date()
}
