//
//  FoodLogDBT.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 3/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class FoodLogDBT: Object {
    @objc dynamic var FoodName: String = ""
    @objc dynamic var FoodDescription: String = ""
    @objc dynamic var FoodRecommendedLevel: Int = 0 // 0 is Unknown, 1 is Good, 2 is Bad
    @objc dynamic var FoodUrl: String = "https://world.openfoodfacts.org/"
    @objc dynamic var DateCreated: Date = Date()
    @objc dynamic var ApiNumber: String = ""
    
    var parentDay = LinkingObjects(fromType: TrackingDayDBT.self, property: "foodLogDT")

}
