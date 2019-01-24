//
//  TrackingDay.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/20/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class TrackingDay: Object {
    let primaryKey = "Primary-Key"
    @objc dynamic var DateCreated: String = ""
    @objc dynamic var FollowProgramStreak: Int = 0
    
    //We save both percentage complete and their total so if we ever change the requirement
    //of completeness, we can remember that their percentage and use that if available
    //and update newer entries to use the new conversion of total
    @objc dynamic var FoodPercentageComplete: Float = 0.0
    @objc dynamic var FoodEatenRating: Int = 0 // Lets define the food scale as 1-5
    @objc dynamic var Omega3PercentageComplete: Float = 0.0
    @objc dynamic var Omega3Total: Float = 0.0
    @objc dynamic var VitaminDPercentageComplete: Float = 0.0
    @objc dynamic var VitaminDTotal: Float = 0.0
    @objc dynamic var ExercisePercentageComplete: Float = 0.0
    @objc dynamic var ExerciseTimeTotal: Float = 0.0
    @objc dynamic var MeditationPercentageComplete: Float = 0.0
    @objc dynamic var MeditationTimeTotal: Float = 0.0
    @objc dynamic var MedicationPercentageComplete: Float = 0.0
    @objc dynamic var MedicationTotal: Int = 0 //currently guess they would add a number of medications
    //you can only take a medication or not, but you could take 2 / 3 for some reason
    
    //Links to data tables
    //FoodStats  let dietStats = List<FoodStats>() or @objc dynamic var category: Category!
    //ExcersizeRoutines
    //MeditationRoutines
    //MedicationRoutines
    //Note that Routines are different from a standard list saved on the phone
    //which they can save and add custom routine names
    
    override static func primaryKey() -> String? {
        return "DateCreated"
    }
}
