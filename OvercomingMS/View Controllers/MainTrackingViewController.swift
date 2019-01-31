//
//  TestTrackingViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/20/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class MainTrackingViewController: UIViewController, TrackingProgressBarDelegate, TrackingFoodBarDelegate {
    
    //MARK: Class properties
    
    private var currentDate : String {// this is for going to previus dates
        get {
            return omsDateFormatter.getFormatedDate(date: globalCurrentFullDate)
        }
    }
    
    private var todaysDate : String {
        get {
            return omsDateFormatter.todaysDate
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
    private lazy var trackingDays: Results<TrackingDayDT> = { self.realm.objects(TrackingDayDT.self) }()
    
    private let omsDateFormatter = OMSDateAccessor()
    
    
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
        
        foodBar.delegate = self
        omega3Bar.delegate = self
        vitaminDBar.delegate = self
        exerciseBar.delegate = self
        meditationBar.delegate = self
        medicationBar.delegate = self
        
        loadCurrentDayUI()
    }
    
    
    private func loadCurrentDayUI() {
        
        if let currentTrackingDay = WriteTrackingDataParent().getTrackingDay(date: currentDate) {
            dateLog.text = currentTrackingDay.DateCreated
            //TODO make a way to get the proper description for each
            //FoodEatenRating is 1 - 5
            foodBar.setDescription(description: ProgressBarConfig.getfoodDescription(rating: currentTrackingDay.FoodEatenRating))
            omega3Bar.setProgressValue(value: currentTrackingDay.Omega3PercentageComplete)
            omega3Bar.setDescription(description: String(currentTrackingDay.Omega3Total))
            vitaminDBar.setProgressValue(value: currentTrackingDay.VitaminDPercentageComplete)
            vitaminDBar.setDescription(description: String(currentTrackingDay.VitaminDTotal))
            exerciseBar.setProgressValue(value: currentTrackingDay.ExercisePercentageComplete)
            exerciseBar.setDescription(description: String(currentTrackingDay.ExerciseTimeTotal))
            meditationBar.setProgressValue(value: currentTrackingDay.MeditationPercentageComplete)
            meditationBar.setDescription(description: String(currentTrackingDay.MeditationTimeTotal))
            medicationBar.setProgressValue(value: currentTrackingDay.MedicationPercentageComplete)
            medicationBar.setDescription(description: String(currentTrackingDay.MedicationTotal))
        }
        else{
            print("Do something for days that were not tracked")
            dateLog.text = currentDate
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
    
    //MARK: Delegates
    
    func didPressCheckButton(_ sender: TrackingFoodBar) {
        
        WriteFoodTrackingData().toggleFilledData()
        
        loadCurrentDayUI()
        
    }
    
    func didPressLeftContainer(_ sender: TrackingFoodBar) {
        
        WriteFoodTrackingData().addData(amount: 1)
        
        loadCurrentDayUI()
        
    }
    
    func didPressCheckButton(_ sender: TrackingProgressBar) {
        
        switch(sender.tag){
        case 0:
            WriteOmega3TrackingData().toggleFilledData()
            break
        case 1:
            WriteVitaminDTrackingData().toggleFilledData()
            break
        case 2:
            WriteExerciseTrackingData().toggleFilledData()
            break
        case 3:
            WriteMeditationTrackingData().toggleFilledData()
            break
        case 4:
            WriteMedicationTrackingData().toggleFilledData()
            break
        default:
            fatalError("Case Not Handled")
            break;
        }
        
        loadCurrentDayUI()
        
    }
    
    func didPressLeftContainer(_ sender: TrackingProgressBar) {
        
        switch(sender.tag){
        case 0:
            WriteOmega3TrackingData().addData(amount: 5)
            break
        case 1:
            WriteVitaminDTrackingData().addData(amount: 5)
            break
        case 2:
            WriteExerciseTrackingData().addData(amount: 5)
            break
        case 3:
            WriteMeditationTrackingData().addData(amount: 5)
            break
        case 4:
            WriteMedicationTrackingData().addData(amount: 1)
            break
        default:
            fatalError("Case Not Handled")
            break;
        }
        
        loadCurrentDayUI()
        
    }
    
    //MARK: IBActions

    @IBAction private func previousDate(_ sender: UIButton) {
        
        globalCurrentFullDate = globalCurrentFullDate.addingTimeInterval(-60*60*24)
        
        loadCurrentDayUI()
    }
    
    @IBAction private func nextDate(_ sender: UIButton) {
        if currentDate == todaysDate {
            return
        }
        
        globalCurrentFullDate = globalCurrentFullDate.addingTimeInterval(60*60*24)
        
        loadCurrentDayUI()
    }
    
    //TODO: this is a test button, normally the day would progress, and the ui is not automatically updated unless we check in the loadCurrentDayUI to check if todays date has changed
    //basically nothing can ever write using current day, they write using todays date
    @IBAction private func ProgressDayPressed(_ sender: UIButton) {
        omsDateFormatter.progressDay()
        
        loadCurrentDayUI()
    }
}
