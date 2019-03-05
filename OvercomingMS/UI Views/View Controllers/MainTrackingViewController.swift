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
    
    @IBOutlet weak var previousButton: UIView!
    @IBOutlet weak var nextDay: UIView!
    
    @IBOutlet weak var GoalButton: CircleButtonSVC!
    @IBOutlet weak var SymptomsButton: CircleButtonSVC!
    @IBOutlet weak var SettingsButton: CircleButtonSVC!
    
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
        
        previousButton.isUserInteractionEnabled = true
        let previusGesture = UITapGestureRecognizer(target: self, action: #selector(previousDate(gesture: )))
        previousButton.addGestureRecognizer(previusGesture)
        
        dateLog.isUserInteractionEnabled = true
        let progressGesture = UITapGestureRecognizer(target: self, action: #selector(ProgressDayPressed(gesture: )))
        dateLog.addGestureRecognizer(progressGesture)
        
        nextDay.isUserInteractionEnabled = true
        let nextGesture = UITapGestureRecognizer(target: self, action: #selector(nextDate(gesture: )))
        nextDay.addGestureRecognizer(nextGesture)

        GoalButton.buttonAction = goalPressed
        SymptomsButton.buttonAction = symptomsPressed
        SettingsButton.buttonAction = settingsPressed
        
        loadCurrentDayUI()
    }
    
    private func loadCurrentDayUI() {
        
        if let currentTrackingDay = TrackingModulesDBS().getTrackingDay(date: globalCurrentDate) {
            updatePageUI(currentTrackingDay)
        }
        else{
            print("Do something for days that were not tracked")
            OMSDateAccessor().createDay(date: globalCurrentDate)
            loadCurrentDayUI()
        }
        
    }
    
    private func updatePageUI(_ currentTrackingDay: TrackingDayDBT) {
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
    
    //MARK: Delegates
    
    func didPressCheckButton(_ sender: TrackingFoodBar) {
        
        //WriteFoodTrackingData().toggleFilledData()
        
        let vc = QuickCompleteFoodVC()
        vc.modalPresentationStyle = .overCurrentContext
        vc.dismissalDelegate = self
        
        self.present(vc, animated: true, completion: nil)
        
        //loadCurrentDayUI()  
    }
    
    func didPressLeftContainer(_ sender: TrackingFoodBar) {
        
        let vc = FoodModuleVC()
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
            let vc = Omega3ModuleVC()
            vc.theme = omega3Bar.colorTheme
            vc.modalPresentationStyle = .overCurrentContext
            vc.dismissalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            break
        case 1:
            //WriteVitaminDTrackingData().addData(amount: 5)
            let vc = VitaminDModuleVC()
            vc.theme = vitaminDBar.colorTheme
            vc.modalPresentationStyle = .overCurrentContext
            vc.dismissalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            break
        case 2:
            let vc = ExerciseModuleVC()
            vc.theme = exerciseBar.colorTheme
            vc.modalPresentationStyle = .overCurrentContext
            vc.dismissalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            break
        case 3:
            let vc = MeditationModuleVC()
            vc.theme = medicationBar.colorTheme
            vc.modalPresentationStyle = .overCurrentContext
            vc.dismissalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            break
        case 4:
            let vc = MedicationModuleVC()
            vc.theme = medicationBar.colorTheme
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

    @objc private func previousDate(gesture: UIGestureRecognizer) {
        
        globalCurrentFullDate = globalCurrentFullDate.addingTimeInterval(-60*60*24)
        
        loadCurrentDayUI()
    }
    
    @objc private func nextDate(gesture: UIGestureRecognizer) {
        if globalCurrentDate == todaysDate {
            return
        }
        
        globalCurrentFullDate = globalCurrentFullDate.addingTimeInterval(60*60*24)
        
        loadCurrentDayUI()
    }
    
    //TODO: this is a test button, normally the day would progress, and the ui is not automatically updated unless we check in the loadCurrentDayUI to check if todays date has changed
    //basically nothing can ever write using current day, they write using todays date
    @objc private func ProgressDayPressed(gesture: UIGestureRecognizer) {
        omsDateFormatter.progressDay()
        
        loadCurrentDayUI()
    }
    
    func goalPressed() {
        let vc = GoalsVC()
        vc.modalPresentationStyle = .overCurrentContext
        vc.dismissalDelegate = self
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func symptomsPressed() {
        let vc = SymptomsVC()
        vc.modalPresentationStyle = .overCurrentContext
        vc.dismissalDelegate = self
        vc.theme = UIColor(red: 130 / 255.0, green: 145 / 255.0, blue: 201 / 255.0, alpha: 1.0)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func settingsPressed() {
        
    }
    
}
