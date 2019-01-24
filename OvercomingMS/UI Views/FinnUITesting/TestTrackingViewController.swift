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
    var todaysDate : Date = Date() // this is to temporarily change the real world date
    var currentDate : Date = Date() // this is for going to previus dates

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

        // Do any additional setup after loading the view
        initializeToday() //TODO: this needs to update much more often then this
        loadTodaysUI()
    }

    
    func initializeToday() {
        
        //TestCode to manually change the current date
        if let today = defaults.object(forKey: "today") as? Date {
            todaysDate = today
        }
        else {
            todaysDate = Date()
            defaults.set(todaysDate, forKey: "today")
        }
        
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
            foodLabel.text = "Food: \(currentTrackingDay.FoodPercentageComplete)%"
            omega3Label.text = "Food: \(currentTrackingDay.Omega3PercentageComplete)%"
            vitaminDLabel.text = "Food: \(currentTrackingDay.VitaminDPercentageComplete )%"
            exerciseLabel.text = "Food: \(currentTrackingDay.ExercisePercentageComplete)%"
            meditationLabel.text = "Food: \(currentTrackingDay.MeditationPercentageComplete)%"
            medicationLabel.text = "Food: \(currentTrackingDay.MedicationPercentageComplete)%"
        }
        else{
            print("Do something for days that were not tracked")
            currentDateLabel.text = getFormatedDate(date: currentDate)
        }
        
        
    }
    
    func getCurrentTrackingDay() -> TrackingDay? {
        return realm.object(ofType: TrackingDay.self, forPrimaryKey: getFormatedDate(date: currentDate))
    }
    
    //MARK: IBActions

    @IBAction func previousDate(_ sender: UIButton) {
        currentDate = currentDate.addingTimeInterval(-60*60*24)
        loadTodaysUI()
    }
    
    @IBAction func nextDate(_ sender: UIButton) {
        currentDate = currentDate.addingTimeInterval(60*60*24)
        loadTodaysUI()
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        print("Clicked Add: \(sender.tag)")
    }
    
    @IBAction func checkClicked(_ sender: UIButton) {
        print("Clicked Check: \(sender.tag)")
    }
}
