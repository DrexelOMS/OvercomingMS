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
        return OMSDateAccessor.getFormatedDate(date: globalCurrentFullDate)
    }
}

class OMSDateAccessor {
    
    let formatter = DateFormatter()
    private let defaults = UserDefaults.standard
    
    private let realm = try! Realm()
    private lazy var trackingDays: Results<TrackingDayDBT> = { self.realm.objects(TrackingDayDBT.self) }()
    
    static func getFormatedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    
    static func getDateTime(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
    
    static func getFullDate(date : String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: date)!
        //TODO: what if we change the date format, maybe it should go through a history of options
    }
    
    static func getDayOfWeekLetter(_ today: String) -> Character {
        let formatter  = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let todayDate = formatter.date(from: today)!
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        let weekdays: [Character] = [
            "U",
            "M",
            "T",
            "W",
            "R",
            "F",
            "S"
        ]
        return weekdays[weekDay - 1]
    }
    
    func greaterThanEqualComparison(dateToCompare: Date) -> Bool {
        let currentDay = OMSDateAccessor.getFullDate(date: globalCurrentDate)
        if let days = dateToCompare.totalDistance(from: currentDay, resultIn: .day) {
            return days >= 0
        }
        return false
    }
    
    var todaysDate : String { // this is to temporarily change the real world date
        get {
            if let today = defaults.object(forKey: "today") as? String {
                initializeTodaysData(date: today)
                return today
            }
            else {
                defaults.set(OMSDateAccessor.getFormatedDate(date: Date()), forKey: "today")
                let date = OMSDateAccessor.getFormatedDate(date: Date())
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
            return OMSDateAccessor.getFullDate(date: todaysDate)
        }
    }
    
    func progressDay() {
        let tomorrow = todaysFullDate.addingTimeInterval(60*60*24)
        todaysDate = OMSDateAccessor.getFormatedDate(date: tomorrow)

    }
    
    private func initializeTodaysData(date : String) {
        if TrackingModulesDBS().getTrackingDay(date: date) == nil {
            do {
                try realm.write(){
                    let todaysTrackingData = TrackingDayDBT()
                    todaysTrackingData.DateCreated = date
                    realm.add(todaysTrackingData)
                }
            } catch {
                print("Error saving TrackingDay: \(error)")
            }
        }
    }
    
}

extension Date {
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func totalDistance(from date: Date, resultIn component: Calendar.Component) -> Int? {
        return Calendar.current.dateComponents([component], from: self, to: date).value(for: component)
    }
    
    func compare(with date: Date, only component: Calendar.Component) -> Int {
        let days1 = Calendar.current.component(component, from: self)
        let days2 = Calendar.current.component(component, from: date)
        return days1 - days2
    }
    
    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        return self.compare(with: date, only: component) == 0
    }
}
