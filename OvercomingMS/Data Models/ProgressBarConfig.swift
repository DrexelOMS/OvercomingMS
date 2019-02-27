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
    static var foodDescriptions : [String] = ["Aweful.", "Not great.", "Alright.", "Pretty good.", "Perfect!"]
    static func getfoodDescription(rating: Int) -> String {
        if(rating - 1 < 0){
            return foodDescriptions[0]
        }
        else if(rating - 1 >= foodDescriptions.count){
            return foodDescriptions[foodDescriptions.count - 1]
        }
        return foodDescriptions[rating - 1]
    }
    
    static let omega3Goal : Int = 100
    static let omega3UOM = "g."
    
    static let vitaminDGoal : Int = 100
    static let vitaminDUOM = "klUs"
    
    static let exerciseGoal : Int = 30
    
    static let meditationGoal : Int = 30
    
    static let lengthUOM = "min."
    
    static func calculateKLUs(minutes: Int) -> Int {
        return minutes * 5
    }
}
