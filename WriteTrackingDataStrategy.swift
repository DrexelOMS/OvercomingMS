//
//  WriteTrackingDataStrategy.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class WriteTrackingDataParent{
    
    let realm = try! Realm()
    lazy var trackingDays: Results<TrackingDay> = { self.realm.objects(TrackingDay.self) }()
    
    func getTrackingDay(date: Date) -> TrackingDay? {
        return realm.object(ofType: TrackingDay.self, forPrimaryKey: OMSDateFormatter.getFormatedDate(date: date))
    }
    
}

class WriteFoodTrackingData : WriteTrackingDataParent {
    
    func toggleFilledData(date : Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    if day.FoodEatenRating != 5 {
                        day.FoodEatenRating = 5
                    }
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func addData(amount: Int, date: Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    day.FoodEatenRating += amount
                    if day.FoodEatenRating > 5 {
                        day.FoodEatenRating = 5
                    }
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
    }
    
}

class WriteOmega3TrackingData : WriteTrackingDataParent {
    
    func toggleFilledData(date : Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    if day.Omega3PercentageComplete != 100 {
                        day.Omega3PercentageComplete = 100
                    }
                    else {
                        var percentage = Float(day.Omega3Total) / Float(ProgressBarConfig.omega3Goal) * 100
                        if percentage > 100 {
                            percentage = 100
                        }
                        day.Omega3PercentageComplete = Int(percentage)
                    }
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func addData(amount: Int, date: Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    day.Omega3Total += amount
                    var percentage = Float(day.Omega3Total) / Float(ProgressBarConfig.omega3Goal) * 100
                    if percentage > 100 {
                        percentage = 100
                    }
                    day.Omega3PercentageComplete = Int(percentage)
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
    }
    
}

class WriteVitaminDTrackingData : WriteTrackingDataParent {
    
    func toggleFilledData(date : Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
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
    
    func addData(amount: Int, date: Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
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

class WriteExerciseTrackingData : WriteTrackingDataParent {
    
    func toggleFilledData(date : Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    if day.ExercisePercentageComplete != 100 {
                        day.ExercisePercentageComplete = 100
                    }
                    else {
                        var percentage = Float(day.ExerciseTimeTotal) / Float(ProgressBarConfig.exerciseGoal) * 100
                        if percentage > 100 {
                            percentage = 100
                        }
                        day.ExercisePercentageComplete = Int(percentage)
                    }
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func addData(amount: Int, date: Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    day.ExerciseTimeTotal += amount
                    var percentage = Float(day.ExerciseTimeTotal) / Float(ProgressBarConfig.exerciseGoal) * 100
                    if percentage > 100 {
                        percentage = 100
                    }
                    day.ExercisePercentageComplete = Int(percentage)
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
    }
    
}

class WriteMeditationTrackingData : WriteTrackingDataParent {
    
    func toggleFilledData(date : Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    if day.MeditationPercentageComplete != 100 {
                        day.MeditationPercentageComplete = 100
                    }
                    else {
                        var percentage = Float(day.MeditationTimeTotal) / Float(ProgressBarConfig.meditationGoal) * 100
                        if percentage > 100 {
                            percentage = 100
                        }
                        day.MeditationPercentageComplete = Int(percentage)
                    }
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func addData(amount: Int, date: Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    day.MeditationTimeTotal += amount
                    var percentage = Float(day.MeditationTimeTotal) / Float(ProgressBarConfig.meditationGoal) * 100
                    if percentage > 100 {
                        percentage = 100
                    }
                    day.MeditationPercentageComplete = Int(percentage)
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
    }
    
}

class WriteMedicationTrackingData : WriteTrackingDataParent {
    
    func toggleFilledData(date : Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    if day.MedicationPercentageComplete != 100 {
                        day.MedicationPercentageComplete = 100
                    }
                    else {
                        var percentage = Float(day.MedicationTotal) / Float(ProgressBarConfig.medicationGoal) * 100
                        if percentage > 100 {
                            percentage = 100
                        }
                        day.MedicationPercentageComplete = Int(percentage)
                    }
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
    }
    
    func addData(amount: Int, date: Date) {
        
        do {
            try realm.write() {
                if let day = getTrackingDay(date: date) {
                    day.MedicationTotal += amount
                    var percentage = Float(day.MedicationTotal) / Float(ProgressBarConfig.medicationGoal) * 100
                    if percentage > 100 {
                        percentage = 100
                    }
                    day.MedicationPercentageComplete = Int(percentage)
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
    }
    
}
