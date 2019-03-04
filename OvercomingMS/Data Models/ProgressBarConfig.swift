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
    
    static private let defaults = UserDefaults.standard
    
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
    
    static private let omega3Key = "omega3Goal"
    static var omega3Goal : Int {
        get {
            return getIntFromKey(_default: 100, _key: omega3Key)
        }
        set {
            defaults.set(newValue, forKey: omega3Key)
        }
    }
    static let omega3UOM = "g."
    
    static private let vitaminDKey = "vitaminDGoal"
    static var vitaminDGoal : Int {
        get {
            return getIntFromKey(_default: 100, _key: vitaminDKey)
        }
        set {
            defaults.set(newValue, forKey: vitaminDKey)
        }
    }
    static let vitaminDUOM = "klUs"
    
    static private let exerciseKey = "exerciseGoal"
    static var exerciseGoal : Int {
        get {
            return getIntFromKey(_default: 30, _key: exerciseKey)
        }
        set {
            defaults.set(newValue, forKey: exerciseKey)
        }
    }
    
    static private let meditationKey = "meditationGoal"
    static var meditationGoal : Int {
        get {
            return getIntFromKey(_default: 30, _key: meditationKey)
        }
        set {
            defaults.set(newValue, forKey: meditationKey)
        }
    }
    
    static let lengthUOM = "min."
    
    static func calculateKLUs(minutes: Int) -> Int {
        return minutes * 5
    }
    
    static private func getIntFromKey(_default: Int, _key: String) -> Int {
        if defaults.contains(key: _key){
            return defaults.integer(forKey: _key)
        }
        else {
            defaults.set(_default, forKey: _key)
            return defaults.integer(forKey: _key)
        }
    }
}

extension UserDefaults {
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
