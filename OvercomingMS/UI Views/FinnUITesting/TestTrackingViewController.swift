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
    
    let defaults = UserDefaults.standard
    var todaysDate : Date { // this is to temporarily change the real world date
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
    var currentDate : Date = Date() {// this is for going to previus dates
        didSet {
            loadTodaysUI()
        }
    }

    @IBOutlet weak var currentDateLabel: UILabel!
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var omega3Label: UILabel!
    @IBOutlet weak var vitaminDLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var meditationLabel: UILabel!
    @IBOutlet weak var medicationLabel: UILabel!
    
    let realm = try! Realm()
    lazy var trackingDays: Results<TrackingDay> = { self.realm.objects(TrackingDay.self) }()
    
    
    //MARK: View Transition Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reset user defaults and realm
//        let defaults = UserDefaults.standard
//        let dictionary = defaults.dictionaryRepresentation()
//        dictionary.keys.forEach { key in
//            defaults.removeObject(forKey: key)
//        }
//        try! realm.write {
//            realm.deleteAll()
//        }
        
        
        // Do any additional setup after loading the view
        currentDate = todaysDate
        initializeTodaysData() //TODO: this needs to update much more often then this
        loadTodaysUI()
    }
    
    func initializeTodaysData() {
        
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
    func shouldInitializeToday() -> Bool {
        if trackingDays.count == 0 {
            return true
        }
        if getFormatedDate(date: todaysDate) ==
            trackingDays[trackingDays.count - 1].DateCreated {
            return false
        }
        else {
            return true
        }
    }
    
    func getFormatedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    
    func loadTodaysUI() {
        //update UI
        if(trackingDays.count <= 0){
            print ("TrackingDays was not initialized")
        }

        
        if  let currentTrackingDay = getCurrentTrackingDay() {
            
            currentDateLabel.text = currentTrackingDay.DateCreated
            foodLabel.text = "Food: \(currentTrackingDay.FoodPercentageComplete * 100)%"
            omega3Label.text = "Omega 3: \(currentTrackingDay.Omega3PercentageComplete * 100)%"
            vitaminDLabel.text = "Vitmin D: \(currentTrackingDay.VitaminDPercentageComplete * 100)%"
            exerciseLabel.text = "Exercise: \(currentTrackingDay.ExercisePercentageComplete * 100)%"
            meditationLabel.text = "Meditation: \(currentTrackingDay.MeditationPercentageComplete * 100)%"
            medicationLabel.text = "Medication: \(currentTrackingDay.MedicationPercentageComplete * 100)%"
        }
        else{
            print("Do something for days that were not tracked")
            currentDateLabel.text = getFormatedDate(date: currentDate)
            foodLabel.text = "Food: Untracked"
            omega3Label.text = "Omega 3: Untracked"
            vitaminDLabel.text = "Vitamin D: Untracked"
            exerciseLabel.text = "Exercise: Untracked"
            meditationLabel.text = "Meditation: Untracked"
            medicationLabel.text = "Medication: Untracked"
        }
        
        
    }
    
    func getCurrentTrackingDay() -> TrackingDay? {
        return realm.object(ofType: TrackingDay.self, forPrimaryKey: getFormatedDate(date: currentDate))
    }
    
    //MARK: IBActions

    @IBAction func previousDate(_ sender: UIButton) {
        currentDate = currentDate.addingTimeInterval(-60*60*24)
    }
    
    @IBAction func nextDate(_ sender: UIButton) {
        if getFormatedDate(date: currentDate) == getFormatedDate(date: todaysDate) {
            return
        }
        currentDate = currentDate.addingTimeInterval(60*60*24)
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        if getFormatedDate(date: currentDate) != getFormatedDate(date: todaysDate) {
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
    
    @IBAction func checkClicked(_ sender: UIButton) {
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
    
    @IBAction func ProgressDayPressed(_ sender: UIButton) {
        todaysDate = todaysDate.addingTimeInterval(60*60*24)
    }
}
