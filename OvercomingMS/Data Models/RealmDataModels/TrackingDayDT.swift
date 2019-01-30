//
//  TrackingDay.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/20/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class TrackingDayDT: Object {
    let primaryKey = "Primary-Key"
    @objc dynamic var DateCreated: String = ""
    @objc dynamic var FollowProgramStreak: Int = 0
    
    //We save both percentage complete and their total so if we ever change the requirement
    //of completeness, we can remember that their percentage and use that if available
    //and update newer entries to use the new conversion of total
    @objc dynamic var FoodEatenRating: Int = 1 // Lets define the food scale as 1-5
    @objc dynamic var Omega3PercentageComplete: Int = 0
    @objc dynamic var Omega3Total: Int = 0
    @objc dynamic var VitaminDPercentageComplete: Int = 0
    @objc dynamic var VitaminDTotal: Int = 0
    
    @objc dynamic var ExercisePercentageComplete: Int = 0
    @objc dynamic var ExerciseTimeTotal: Int = 0
    let exerciseRoutinesDT = List<ExerciseRoutinesDT>()
    
    @objc dynamic var MeditationPercentageComplete: Int = 0
    @objc dynamic var MeditationTimeTotal: Int = 0
    @objc dynamic var MedicationPercentageComplete: Int = 0
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
