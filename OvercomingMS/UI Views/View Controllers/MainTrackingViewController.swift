//
//  TestTrackingViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/20/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class MainTrackingViewController: UIViewController, DismissalDelegate, TrackingProgressBarDelegate, TrackingFoodBarDelegate {
    
    func finishedShowing(viewController: UIViewController) {
        print("ReloadedData")
        loadCurrentDayUI()
    }
    
    
    //MARK: Class properties
    
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
    
    @IBOutlet weak var previousButton: CircleButtonSVC!
    @IBOutlet weak var progressDayButton: CircleButtonSVC!
    @IBOutlet weak var nextDay: CircleButtonSVC!
    
    
    private let realm = try! Realm()
    private lazy var trackingDays: Results<TrackingDayDBT> = { self.realm.objects(TrackingDayDBT.self) }()
    
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
        
        previousButton.buttonAction = previousDate;
        progressDayButton.buttonAction = ProgressDayPressed;
        nextDay.buttonAction = nextDate
        
        loadCurrentDayUI()
    }
    
    private func loadCurrentDayUI() {
        
        if let currentTrackingDay = TrackingModulesDBS().getTrackingDay(date: globalCurrentDate) {
            dateLog.text = currentTrackingDay.DateCreated
            //TODO make a way to get the proper description for each
            //FoodEatenRating is 1 - 5
            foodBar.setDescription(description: ProgressBarConfig.getfoodDescription(rating: currentTrackingDay.FoodEatenRating))
            omega3Bar.setProgressValue(value: currentTrackingDay.Omega3ComputedPercentageComplete)
            omega3Bar.setDescription(description: String(currentTrackingDay.Omega3Total))
            vitaminDBar.setProgressValue(value: currentTrackingDay.VitaminDComputedPercentageComplete)
            vitaminDBar.setDescription(description: String(currentTrackingDay.VitaminDTotal))
            exerciseBar.setProgressValue(value: currentTrackingDay.ExerciseComputedPercentageComplete)
            exerciseBar.setDescription(description: String(currentTrackingDay.ExerciseTimeTotal))
            meditationBar.setProgressValue(value: currentTrackingDay.MeditationComputedPercentageComplete)
            meditationBar.setDescription(description: String(currentTrackingDay.MeditationTimeTotal))
            medicationBar.setProgressValue(value: currentTrackingDay.MedicationComputedPercentageComplete)
            medicationBar.setDescription(description: String(currentTrackingDay.MedicationTotal))
        }
        else{
            print("Do something for days that were not tracked")
            dateLog.text = globalCurrentDate
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
        
        //WriteFoodTrackingData().toggleFilledData()
        
        let storyboard = UIStoryboard(name: "QuickCompleteFood", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuickCompleteFoodVC") as! QuickCompleteFoodVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.dismissalDelegate = self
        
        self.present(vc, animated: true, completion: nil)
        
        //loadCurrentDayUI()  
    }
    
    func didPressLeftContainer(_ sender: TrackingFoodBar) {
        
        let storyboard = UIStoryboard(name: "TrackingModuleStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FoodModuleVC") as! FoodModuleVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.dismissalDelegate = self
        
        self.present(vc, animated: true, completion: nil)
        
        loadCurrentDayUI()
        
    }
    
    func didPressCheckButton(_ sender: TrackingProgressBar) {
        
        switch(sender.tag){
        case 0:
            Omega3HistoryDBS().toggleFilledData()
            break
        case 1:
            VitaminDHistoryDBS().toggleFilledData()
            break
        case 2:
            ExerciseHistoryDBS().toggleFilledData()
            break
        case 3:
            MeditationHistoryDBS().toggleFilledData()
            break
        case 4:
            SavedMedicationDBS().toggleFilledData()
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
            let storyboard = UIStoryboard(name: "TrackingModuleStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Omega3ModuleVC") as! Omega3ModuleVC
            vc.modalPresentationStyle = .overCurrentContext
            vc.dismissalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            break
        case 1:
            //WriteVitaminDTrackingData().addData(amount: 5)
            let storyboard = UIStoryboard(name: "TrackingModuleStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "VitaminDModuleVC") as! VitaminDModuleVC
            vc.modalPresentationStyle = .overCurrentContext
            vc.dismissalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            break
        case 2:
            let storyboard = UIStoryboard(name: "TrackingModuleStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ExerciseModuleVC") as! ExerciseModuleVC
            vc.modalPresentationStyle = .overCurrentContext
            vc.dismissalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            break
        case 3:
            let storyboard = UIStoryboard(name: "TrackingModuleStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MeditationModuleVC") as! MeditationModuleVC
            vc.modalPresentationStyle = .overCurrentContext
            vc.dismissalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            break
        case 4:
            let storyboard = UIStoryboard(name: "TrackingModuleStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MedicationModuleVC") as! MedicationModuleVC
            vc.modalPresentationStyle = .overCurrentContext
            vc.dismissalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            break
        default:
            fatalError("Case Not Handled")
            break;
        }
        
        loadCurrentDayUI()
        
    }
    
    //MARK: IBActions

    private func previousDate() {
        
        globalCurrentFullDate = globalCurrentFullDate.addingTimeInterval(-60*60*24)
        
        loadCurrentDayUI()
    }
    
    private func nextDate() {
        if globalCurrentDate == todaysDate {
            return
        }
        
        globalCurrentFullDate = globalCurrentFullDate.addingTimeInterval(60*60*24)
        
        loadCurrentDayUI()
    }
    
    //TODO: this is a test button, normally the day would progress, and the ui is not automatically updated unless we check in the loadCurrentDayUI to check if todays date has changed
    //basically nothing can ever write using current day, they write using todays date
    private func ProgressDayPressed() {
        omsDateFormatter.progressDay()
        
        loadCurrentDayUI()
    }
}
