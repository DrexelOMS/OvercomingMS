//
//  WriteTrackingDataStrategy.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class FoodRatingDBS : TrackingModulesDBS {
    
    override var module: Modules {
        get {
            return .Food
        }
    }
    
    override func addQuickCompleteItem() {
        setRating(amount: ProgressBarConfig.foodRatingGoal)
    }
    
    func getRating() -> Int {
        let rating = getTrackingDay().FoodEatenRating
        return rating
    }
    
     // food doesnt have a progress bar
    override func getPercentageComplete() -> Int {
        if getTrackingDay().IsFoodComplete {
            return 100
        }
        return 0
    }
    
    override func getTrackingDescription() -> String {
        return ProgressBarConfig.getfoodDescription(rating: getTrackingDay().FoodEatenRating)
    }
    
    //must be 1-5
   func setRating(amount: Int) {
        let percent = getPercentageComplete()
        do {
            try realm.safeWrite() {
                if amount < 1 {
                    getTrackingDay().FoodEatenRating = 1
                }
                else if amount > 5{
                    getTrackingDay().FoodEatenRating = 5
                }
                else {
                    getTrackingDay().FoodEatenRating = amount
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        checkToNotify(oldPercent: percent)
    }
    
}
