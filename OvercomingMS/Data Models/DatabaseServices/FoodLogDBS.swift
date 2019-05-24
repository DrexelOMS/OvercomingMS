// Food Log is not currently used
////
////  FoodLogDBS.swift
////  OvercomingMS
////
////  Created by Cassandra Li on 3/7/19.
////  Copyright © 2019 DrexelOMS. All rights reserved.
////
//
//
///*
// a way to add item,
// get the list of items for that day
// get the list of ALL items
// delete an item
// */
//
//import Foundation
//import RealmSwift
//
//class FoodLogDBS {
//
//    let realm = try! Realm()
//    var day : TrackingDayDBT {
//        get {
//            return TrackingModulesDBS(editingDate: globalCurrentDate).getTrackingDay()
//        }
//    }
//
//    func addFoodItem(foodName: String, foodDescription: String, foodRecommendedLevel: Int, foodURL: String, dateCreated: Date, apiNumber: String) {
//        do {
//            try realm.safeWrite() {
//                let item = FoodLogDBT()
//                item.FoodName = foodName
//                item.FoodDescription = foodDescription
//                item.FoodRecommendedLevel = foodRecommendedLevel
//                item.FoodUrl = foodURL
//                item.DateCreated=dateCreated
//                item.ApiNumber = apiNumber
//                day.foodLogDT.append(item)
//            }
//        }
//        catch {
//            print("Error updating food data : \(error)" )
//        }
//    }
//
//
//
//    func getTodaysFoodItems() -> List<FoodLogDBT>? {
//        return day.foodLogDT
//    }
//
//    func getAllFoodItems() -> List<FoodLogDBT>? {
//        return List<FoodLogDBT>()
//    }
//
//
//    func deleteFoodItem(item: FoodLogDBT) {
//        do {
//            try realm.safeWrite() {
//                realm.delete(item)
//            }
//        } catch {
//            print("Error update Food data: \(error)")
//        }
//    }
//
//
//}
