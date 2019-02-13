//
//  WriteTrackingDataStrategy.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class WriteFoodTrackingData : TrackingModulesDBS {
    
    func toggleFilledData() {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: globalCurrentDate) {
                    if day.FoodEatenRating != 5 {
                        day.FoodEatenRating = 5
                    }
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    //must be 1-5
   func setRating(amount: Int) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: globalCurrentDate) {
                    if amount < 1 {
                        day.FoodEatenRating = 1
                    }
                    else if amount > 5{
                        day.FoodEatenRating = 5
                    }
                    else {
                        day.FoodEatenRating = amount
                    }
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
    }
}



class WriteVitaminDTrackingData : TrackingModulesDBS {
    
    func toggleFilledData() {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: globalCurrentDate) {
                    if day.VitaminDPercentageComplete != 100 {
                        day.VitaminDPercentageComplete = 100
                    }
                    else {
                        var percentage = Float(day.VitaminDTotal) / Float(ProgressBarConfig.vitaminDGoal) * 100
                        if percentage > 100 {
                            percentage = 100
                        }
                        day.VitaminDPercentageComplete = Int(percentage)
                    }
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func addData(amount: Int) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: globalCurrentDate) {
                    day.VitaminDTotal += amount
                    var percentage = Float(day.VitaminDTotal) / Float(ProgressBarConfig.vitaminDGoal) * 100
                    if percentage > 100 {
                        percentage = 100
                    }
                    day.VitaminDPercentageComplete = Int(percentage)
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
    }
    
}

