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
    @objc dynamic var trackingDate: Date = Date()
    @objc dynamic var dietTotal: Int = 0
    let dietStats = List<FoodStats>()
}
