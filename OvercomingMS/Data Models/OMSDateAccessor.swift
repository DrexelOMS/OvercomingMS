//
//  OMSDateFormater.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

var globalCurrentFullDate : Date = OMSDateAccessor().todaysFullDate

var globalCurrentDate : String {// this is for going to previus dates
    get {
        return OMSDateAccessor().getFormatedDate(date: globalCurrentFullDate)
    }
}

class OMSDateAccessor {
    
    let formatter = DateFormatter()
    private let defaults = UserDefaults.standard
    
    private let realm = try! Realm()
    private lazy var trackingDays: Results<TrackingDay> = { self.realm.objects(TrackingDay.self) }()
    
    func getFormatedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    
    func getFullDate(date : String) -> Date {
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: date)!
        //TODO: what if we change the date format, maybe it should go through a history of options
    }
    
    var todaysDate : String { // this is to temporarily change the real world date
        get {
            if let today = defaults.object(forKey: "today") as? String {
                initializeTodaysData(date: today)
                return today
            }
            else {
                defaults.set(getFormatedDate(date: Date()), forKey: "today")
                let date = getFormatedDate(date: Date())
                initializeTodaysData(date: date)
                return date
            }
        }
        set {
            defaults.set(newValue, forKey: "today")
        }
    }
    
    var todaysFullDate : Date {
        get {
            return getFullDate(date: todaysDate)
        }
    }
    
    func progressDay() {
        let tomorrow = todaysFullDate.addingTimeInterval(60*60*24)
        todaysDate = getFormatedDate(date: tomorrow)

    }
    
    private func initializeTodaysData(date : String) {
        if WriteTrackingDataParent().getTrackingDay(date: date) == nil {
            do {
                try realm.write(){
                    let todaysTrackingData = TrackingDay()
                    todaysTrackingData.DateCreated = date
                    realm.add(todaysTrackingData)
                }
            } catch {
                print("Error saving TrackingDay: \(error)")
            }
        }
    }
    
}
