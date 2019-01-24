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
    var todaysDate : Date = Date()
    var currentDate : Date = Date()

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
                    todaysTrackingData.DateCreated = todaysDate
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
            getFormatedDate(date: trackingDays[trackingDays.count - 1].DateCreated) {
            return false
        }
        else {
            return true
        }
    }
    
    func getFormatedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    func loadTodaysUI() {
        //update UI
        if(trackingDays.count <= 0){
            print ("TrackingDays was not initialized")
        }
        
        if true { //check if trackingDays contains the currentDate
            let todaysTrackingStats = trackingDays[trackingDays.count - 1]
            currentDateLabel.text = getFormatedDate(date: todaysTrackingStats.DateCreated)
            foodLabel.text = "Food: \(todaysTrackingStats.FoodPercentageComplete)%"
            omega3Label.text = "Food: \(todaysTrackingStats.Omega3PercentageComplete)%"
            vitaminDLabel.text = "Food: \(todaysTrackingStats.VitaminDPercentageComplete )%"
            exerciseLabel.text = "Food: \(todaysTrackingStats.ExercisePercentageComplete)%"
            meditationLabel.text = "Food: \(todaysTrackingStats.MeditationPercentageComplete)%"
            medicationLabel.text = "Food: \(todaysTrackingStats.MedicationPercentageComplete)%"
        }
        
        
    }
    
    //MARK: IBActions

    @IBAction func previousDate(_ sender: UIButton) {
        print("see previous days data")
    }
    
    @IBAction func nextDate(_ sender: UIButton) {
        print("go to tomorrow")
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        print("Clicked Add: \(sender.tag)")
    }
    
    @IBAction func checkClicked(_ sender: UIButton) {
        print("Clicked Check: \(sender.tag)")
    }
}
