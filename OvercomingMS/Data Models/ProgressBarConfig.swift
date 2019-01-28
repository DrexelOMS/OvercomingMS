//
//  ProgressBarConfig.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation

enum TrackingMode { case food, omega3, vitaminD, exercise, meditation, medication }

class ProgressBarConfig {
    static var foodDescriptions : [String] = ["Aweful", "Not great", "Alright", "Pretty good", "Perfect!"]
    
    static let omega3Goal : Int = 100
    static let omega3UOM = "grams"
    
    static let vitaminDGoal : Int = 100
    static let vitaminDUOM = "supp."
    
    static let exerciseGoal : Int = 30
    static let exerciseUOM = "min."
    
    static let meditationGoal : Int = 30
    static let meditationUOM = "min."
    
    static let medicationGoal : Int = 5
    static let medicationUOM = "meds"
    
    static func buildDescription(amount: Int, uom: String) -> String {
        return "\(amount) \(uom) left"
    }
}
