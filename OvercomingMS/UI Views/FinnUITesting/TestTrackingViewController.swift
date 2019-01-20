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

    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var dietLabel: UILabel!
    @IBOutlet weak var excerciseLabel: UILabel!
    @IBOutlet weak var vitaminDLabel: UILabel!
    
    
    let realm = try! Realm()
    var trackingDays: Results<TrackingDay>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeToday()
        loadTodaysUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Do anything that needs to happen if this view will show up
        loadTodaysUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TestUpdateTrackingViewController
        
        destinationVC.selectedDay = trackingDays?[0]
    }
    
    
    
    func initializeToday() {
        
        trackingDays = realm.objects(TrackingDay.self)
        
        //TODO: check if todays data has been initialized
        if let days = trackingDays {
            if days.count == 0 {            //write first date
                let today = TrackingDay()
                do {
                    try realm.write {
                        realm.add(today)
                    }
                } catch {
                    print("Error saving TrackingDay: \(error)")
                }
            }
        }
        
    }
    
    func loadTodaysUI() {
        
        //Get todays data
        trackingDays = realm.objects(TrackingDay.self)
        
        //update UI
        if let days = trackingDays {
            if days.count > 0 {
                let day = days[0]
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MMM-yyyy"
                currentDateLabel.text = formatter.string(from: day.trackingDate)
                if day.dietStats.count > 0 {
                    dietLabel.text = "Diet: " + String(day.dietStats[day.dietStats.count - 1].foodOmega3Count)
                }
            }
        }
        
    }
    
    

    @IBAction func previousDate(_ sender: UIButton) {
    }
    
    @IBAction func nextDate(_ sender: UIButton) {
    }
    
}
