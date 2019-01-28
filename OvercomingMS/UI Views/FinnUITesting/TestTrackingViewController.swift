//
//  TestTrackingViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/20/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class TestTrackingViewController: UIViewController, TrackingProgressBarDelegate, TrackingFoodBarDelegate {
    
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
    
    @IBOutlet weak var dateLog: UILabel!
    @IBOutlet weak var foodBar: TrackingFoodBar!
    @IBOutlet weak var omega3Bar: TrackingProgressBar!
    @IBOutlet weak var vitaminDBar: TrackingProgressBar!
    @IBOutlet weak var exerciseBar: TrackingProgressBar!
    @IBOutlet weak var meditationBar: TrackingProgressBar!
    @IBOutlet weak var medicationBar: TrackingProgressBar!
    
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
        
        if getTrackingDay(date: todaysDate) == nil {
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
        
        if let currentTrackingDay = getCurrentTrackingDay() {
            dateLog.text = currentTrackingDay.DateCreated
            //TODO make a way to get the proper description for each
            //FoodEatenRating is 1 - 5
            foodBar.setDescription(description: ProgressBarConfig.foodDescriptions[currentTrackingDay.FoodEatenRating - 1])
            omega3Bar.setProgressValue(value: currentTrackingDay.Omega3PercentageComplete * 100)
            omega3Bar.setDescription(description: "")
            vitaminDBar.setProgressValue(value: currentTrackingDay.VitaminDPercentageComplete * 100)
            vitaminDBar.setDescription(description: "")
            exerciseBar.setProgressValue(value: currentTrackingDay.ExercisePercentageComplete * 100)
            exerciseBar.setDescription(description: "")
            meditationBar.setProgressValue(value: currentTrackingDay.MeditationPercentageComplete * 100)
            meditationBar.setDescription(description: "")
            medicationBar.setProgressValue(value: currentTrackingDay.MedicationPercentageComplete * 100)
            medicationBar.setDescription(description: "")
        }
        else{
            print("Do something for days that were not tracked")
            dateLog.text = getFormatedDate(date: currentDate)
            foodBar.setDescription(description: "Untracked")
            omega3Bar.setProgressValue(value: 0)
            omega3Bar.setDescription(description: "Untracked")
            vitaminDBar.setProgressValue(value: 0)
            vitaminDBar.setDescription(description: "Untracked")
            exerciseBar.setProgressValue(value: 0)
            exerciseBar.setDescription(description: "Untracked")
            meditationBar.setProgressValue(value: 0)
            meditationBar.setDescription(description: "Untracked")
            medicationBar.setProgressValue(value: 0)
            medicationBar.setDescription(description: "Untracked")
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
    
    //MARK: Delegates
    
    func didPressCheckButton(_ sender: TrackingFoodBar) {
        print(sender.tag)
    }
    
    func didPressLeftContainer(_ sender: TrackingFoodBar) {
        print(sender.tag)
    }
    
    func didPressCheckButton(_ sender: TrackingProgressBar) {
        print(sender.tag)
    }
    
    func didPressLeftContainer(_ sender: TrackingProgressBar) {
        print(sender.tag)
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
