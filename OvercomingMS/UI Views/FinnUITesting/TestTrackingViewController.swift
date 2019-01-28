//
//  TestTrackingViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/20/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class TestTrackingViewController: UIViewController {
    
    //MARK: Class properties
    
    private let defaults = UserDefaults.standard
    private var todaysDate : Date { // this is to temporarily change the real world date
        get {
            if let today = defaults.object(forKey: "today") as? Date {
                return today
            }
            else {
                defaults.set(Date(), forKey: "today")
                return Date()
            }
        }
        set {
            defaults.set(newValue, forKey: "today")
            currentDate = todaysDate
            initializeTodaysData()
            loadTodaysUI()
        }
    }
    private var currentDate : Date = Date() {// this is for going to previus dates
        didSet {
            loadTodaysUI()
        }
    }
    
    @IBOutlet private weak var foodLabel: UILabel!
    @IBOutlet private weak var omega3Label: UILabel!
    @IBOutlet private weak var vitaminDLabel: UILabel!
    @IBOutlet private weak var exerciseLabel: UILabel!
    @IBOutlet private weak var meditationLabel: UILabel!
    @IBOutlet private weak var medicationLabel: UILabel!
    
    private let realm = try! Realm()
    private lazy var trackingDays: Results<TrackingDay> = { self.realm.objects(TrackingDay.self) }()
    
    
    //MARK: View Transition Initializers
    
    //TODO: Consider changing to view will appear, and initialize TodaysData should be handled everytime the app enters the foreground
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        
        //reset user defaults and realm
//        let defaults = UserDefaults.standard
//        let dictionary = defaults.dictionaryRepresentation()
//        dictionary.keys.forEach { key in
//            defaults.removeObject(forKey: key)
//        }
//        try! realm.write {
//            realm.deleteAll()
//        }
    
        currentDate = todaysDate
        initializeTodaysData() //TODO: this should occur when app enters foreground
        loadTodaysUI()
    }
    
    private func initializeTodaysData() {
        
        if shouldInitializeToday() {
            do {
                try realm.write(){
                    let todaysTrackingData = TrackingDay()
                    todaysTrackingData.DateCreated = getFormatedDate(date: todaysDate)
                    realm.add(todaysTrackingData)
                }
            } catch {
                print("Error saving TrackingDay: \(error)")
            }
        }
        
    }
    
    //check if the currentDay is not the last trackingDay
    private func shouldInitializeToday() -> Bool {
//        if trackingDays.count == 0 {
//            return true
//        }
//        if getFormatedDate(date: todaysDate) ==
//            trackingDays[trackingDays.count - 1].DateCreated {
//            return false
//        }
//        else {
//            return true
//        }
        
        if getTrackingDay(date: todaysDate) != nil {
            return true
        }
        else {
            return false
        }
        
    }
    
    private func loadTodaysUI() {
        //update UI
        if(trackingDays.count <= 0){
            fatalError("TrackingDays was not initialized")
        }
        
        if  let currentTrackingDay = getCurrentTrackingDay() {
            print(currentTrackingDay.DateCreated)
            foodLabel.text = "Food: \(currentTrackingDay.FoodPercentageComplete * 100)%"
            omega3Label.text = "Omega 3: \(currentTrackingDay.Omega3PercentageComplete * 100)%"
            vitaminDLabel.text = "Vitmin D: \(currentTrackingDay.VitaminDPercentageComplete * 100)%"
            exerciseLabel.text = "Exercise: \(currentTrackingDay.ExercisePercentageComplete * 100)%"
            meditationLabel.text = "Meditation: \(currentTrackingDay.MeditationPercentageComplete * 100)%"
            medicationLabel.text = "Medication: \(currentTrackingDay.MedicationPercentageComplete * 100)%"
        }
        else{
            print("Do something for days that were not tracked")
            print(getFormatedDate(date: currentDate))
            foodLabel.text = "Food: Untracked"
            omega3Label.text = "Omega 3: Untracked"
            vitaminDLabel.text = "Vitamin D: Untracked"
            exerciseLabel.text = "Exercise: Untracked"
            meditationLabel.text = "Meditation: Untracked"
            medicationLabel.text = "Medication: Untracked"
        }
        
    }
    
    private func getCurrentTrackingDay() -> TrackingDay? {
        return realm.object(ofType: TrackingDay.self, forPrimaryKey: getFormatedDate(date: currentDate))
    }
    
    private func getTrackingDay(date: Date) -> TrackingDay? {
        return realm.object(ofType: TrackingDay.self, forPrimaryKey: getFormatedDate(date: date))
    }
    
    private func getFormatedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    
    //MARK: IBActions

    @IBAction private func previousDate(_ sender: UIButton) {
        currentDate = currentDate.addingTimeInterval(-60*60*24)
    }
    
    @IBAction private func nextDate(_ sender: UIButton) {
        if getFormatedDate(date: currentDate) == getFormatedDate(date: todaysDate) {
            return
        }
        currentDate = currentDate.addingTimeInterval(60*60*24)
    }
    
    @IBAction private func addClicked(_ sender: UIButton) {
        if getFormatedDate(date: currentDate) != getFormatedDate(date: todaysDate) {
            //Don't allow modification of data if currentDate is not today
            return
        }
        
        do {
            try realm.write() {
                if let day = getCurrentTrackingDay() {
                    day.FoodEatenRating += 1
                    if day.FoodEatenRating > 5 {
                        day.FoodEatenRating = 5
                    }
                    day.FoodPercentageComplete = Float(day.FoodEatenRating) / 5
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
        loadTodaysUI()
    }
    
    @IBAction private func checkClicked(_ sender: UIButton) {
        if getFormatedDate(date: currentDate) != getFormatedDate(date: todaysDate) {
            return
        }
        
        do {
            try realm.write() {
                if let day = getCurrentTrackingDay() {
                    if day.FoodPercentageComplete != 1 {
                        day.FoodPercentageComplete = 1
                    }
                    else {
                        day.FoodPercentageComplete = Float(day.FoodEatenRating) / 5
                    }
                }
            }
        } catch {
            print("Error updating todays data : \(error)" )
        }
        
        loadTodaysUI()
    }
    
    @IBAction private func ProgressDayPressed(_ sender: UIButton) {
        todaysDate = todaysDate.addingTimeInterval(60*60*24)
    }
}
