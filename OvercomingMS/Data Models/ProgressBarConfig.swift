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
    
    static var omega3Goal : Int {
        get {
            return o3g
        }
        set {
            o3g = newValue
        }
    }
    static private var o3g = 100
    static let omega3UOM = "g."
    
    static var vitaminDGoal : Int {
        get {
            return vdg
        }
        set {
            vdg = newValue
        }
    }
    static private var vdg = 100
    static let vitaminDUOM = "klUs"
    
    static var exerciseGoal : Int {
        get {
            return eg
        }
        set {
            eg = newValue
        }
    }
    static private var eg = 30
    
    static var meditationGoal : Int {
        get {
            return mg
        }
        set {
            mg = newValue
        }
    }
    static private var mg = 30
    
    static let lengthUOM = "min."
    
    static func calculateKLUs(minutes: Int) -> Int {
        return minutes * 5
    }
}
