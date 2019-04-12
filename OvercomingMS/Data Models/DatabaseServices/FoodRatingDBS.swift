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
    
    func toggleFilledData() {
        
        do {
            try realm.write() {
                let day = getTrackingDay(date: globalCurrentDate)
                if day.FoodEatenRating != 5 {
                    day.FoodEatenRating = 5
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func getRating() -> Int {
        let day = getTrackingDay(date: globalCurrentDate)
        let rating = day.FoodEatenRating
        return rating
    }
    
     // food doesnt have a progress bar
    override func getPercentageComplete() -> Int {
        return 0
    }
    
    override func getTrackingDescription() -> String {
        return ProgressBarConfig.getfoodDescription(rating: getTrackingDay().FoodEatenRating)
    }
    
    //must be 1-5
   func setRating(amount: Int) {
        
        do {
            try realm.write() {
                let day = getTrackingDay(date: globalCurrentDate)
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
        } catch {
            print("Error updating todays data : \(error)" )
        }
    }
    
}
