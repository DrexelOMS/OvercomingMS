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
    var currentDay : Date = Date()

    @IBOutlet weak var currentDateLabel: UILabel!
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var omega3Label: UILabel!
    @IBOutlet weak var vitaminDLabel: UILabel!
    @IBOutlet weak var excerciseLabel: UILabel!
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
            currentDay = today
        }
        else {
            currentDay = Date()
            defaults.set(currentDay, forKey: "today")
        }

        
        //TODO: check if the currentDay is not inside the last item inside
        if trackingDays.count == 0 || shouldInitializeToday() {
            do {
                try realm.write(){
                    let todaysTrackingData = TrackingDay()
                    todaysTrackingData.DateCreated = currentDay
                    realm.add(todaysTrackingData)
                }
            } catch {
                print("Error saving TrackingDay: \(error)")
            }
        }
        
    }
    
    func shouldInitializeToday() -> Bool {
        return false
    }
    
    func loadTodaysUI() {
        //update UI
        if trackingDays.count > 0 {
            let day = trackingDays[0]
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-yyyy"
            currentDateLabel.text = formatter.string(from: day.DateCreated)
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
        print("Clicked : \(sender.tag)")
    }
    
    @IBAction func checkClicked(_ sender: UIButton) {
        print("Clicked : \(sender.tag)")
    }
}
