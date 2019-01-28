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
            initializeTodaysData()
            currentDate = todaysDate
            loadCurrentDayUI()
        }
    }
    private var currentDate : Date = Date() {// this is for going to previus dates
        didSet {
            loadCurrentDayUI()
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
        
        foodBar.delegate = self
        omega3Bar.delegate = self
        vitaminDBar.delegate = self
        exerciseBar.delegate = self
        meditationBar.delegate = self
        medicationBar.delegate = self
        
        initializeTodaysData() //TODO: this should occur when app enters foreground
        currentDate = todaysDate
        loadCurrentDayUI()
    }
    
    private func initializeTodaysData() {
        
        if shouldInitializeToday() {
            do {
                try realm.write(){
                    let todaysTrackingData = TrackingDay()
                    todaysTrackingData.DateCreated = OMSDateFormatter.getFormatedDate(date: todaysDate)
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
        
        if WriteTrackingDataParent().getTrackingDay(date: todaysDate) == nil {
            return true
        }
        else {
            return false
        }
        
    }
    
    private func loadCurrentDayUI() {
        //update UI
        if(trackingDays.count <= 0){
            fatalError("TrackingDays was not initialized")
        }
        
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
            dateLog.text = OMSDateFormatter.getFormatedDate(date: currentDate)
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

        if OMSDateFormatter.getFormatedDate(date: currentDate) != OMSDateFormatter.getFormatedDate(date: todaysDate) {
            return
        }
        
        WriteFoodTrackingData().toggleFilledData(date: todaysDate)
        
        loadCurrentDayUI()
        
    }
    
    func didPressLeftContainer(_ sender: TrackingFoodBar) {
        
        if OMSDateFormatter.getFormatedDate(date: currentDate) != OMSDateFormatter.getFormatedDate(date: todaysDate) {
        //Don't allow modification of data if currentDate is not today
        return
        }
        
        WriteFoodTrackingData().addData(amount: 1, date: todaysDate)
        
        loadCurrentDayUI()
        
    }
    
    func didPressCheckButton(_ sender: TrackingProgressBar) {

        if OMSDateFormatter.getFormatedDate(date: currentDate) != OMSDateFormatter.getFormatedDate(date: todaysDate) {
            return
        }
        
        switch(sender.tag){
        case 0:
            WriteOmega3TrackingData().toggleFilledData(date: todaysDate)
            break
        case 1:
            WriteVitaminDTrackingData().toggleFilledData(date: todaysDate)
            break
        case 2:
            WriteExerciseTrackingData().toggleFilledData(date: todaysDate)
            break
        case 3:
            WriteMeditationTrackingData().toggleFilledData(date: todaysDate)
            break
        case 4:
            WriteMedicationTrackingData().toggleFilledData(date: todaysDate)
            break
        default:
            fatalError("Case Not Handled")
            break;
        }
        
        loadCurrentDayUI()
        
    }
    
    func didPressLeftContainer(_ sender: TrackingProgressBar) {

        if OMSDateFormatter.getFormatedDate(date: currentDate) != OMSDateFormatter.getFormatedDate(date: todaysDate) {
            //Don't allow modification of data if currentDate is not today
            return
        }
        
        switch(sender.tag){
        case 0:
            WriteOmega3TrackingData().addData(amount: 5, date: todaysDate)
            break
        case 1:
            WriteVitaminDTrackingData().addData(amount: 5, date: todaysDate)
            break
        case 2:
            WriteExerciseTrackingData().addData(amount: 5, date: todaysDate)
            break
        case 3:
            WriteMeditationTrackingData().addData(amount: 5, date: todaysDate)
            break
        case 4:
            WriteMedicationTrackingData().addData(amount: 1, date: todaysDate)
            break
        default:
            fatalError("Case Not Handled")
            break;
        }
        
        loadCurrentDayUI()
        
    }
    
    //MARK: IBActions

    @IBAction private func previousDate(_ sender: UIButton) {
        currentDate = currentDate.addingTimeInterval(-60*60*24)
    }
    
    @IBAction private func nextDate(_ sender: UIButton) {
        if OMSDateFormatter.getFormatedDate(date: currentDate) == OMSDateFormatter.getFormatedDate(date: todaysDate) {
            return
        }
        currentDate = currentDate.addingTimeInterval(60*60*24)
    }
    
    @IBAction private func ProgressDayPressed(_ sender: UIButton) {
        todaysDate = todaysDate.addingTimeInterval(60*60*24)
    }
}
