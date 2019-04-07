//
//  TestTrackingViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/20/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class MainTrackingViewController: UIViewController, DismissalDelegate, TrackingProgressBarDelegate {
    
    func finishedShowing(viewController: UIViewController) {
        _ = omsDateFormatter.todaysDate
        loadCurrentDayUI()
    }
    
    
    //MARK: Class properties
    
    private var todaysDate : String {
        get {
            return omsDateFormatter.todaysDate
        }
    }
    
    @IBOutlet weak var header: HeaderSVC!
    @IBOutlet weak var dateLog: UILabel!
    @IBOutlet weak var foodBar: TrackingFoodBar!
    @IBOutlet weak var omega3Bar: Omega3ProgressBar!
    @IBOutlet weak var vitaminDBar: VitaminDProgressBar!
    @IBOutlet weak var exerciseBar: ExerciseProgressBar!
    @IBOutlet weak var meditationBar: MeditationProgressBar!
    @IBOutlet weak var medicationBar: MedicationProgressBar!
    
    @IBOutlet weak var previousButton: UIView!
    @IBOutlet weak var nextDay: UIView!
    
    @IBOutlet weak var GoalButton: CircleButtonSVC!
    @IBOutlet weak var SymptomsButton: CircleButtonSVC!
    @IBOutlet weak var SettingsButton: CircleButtonSVC!
    
    private let realm = try! Realm()
    private lazy var trackingDays: Results<TrackingDayDBT> = { self.realm.objects(TrackingDayDBT.self) }()
    
    private let omsDateFormatter = OMSDateAccessor()
    
    //MARK: View Transition Initializers
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidCompleteModule(_:)), name: .didCompleteModule, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onTodaysDateChanged(_:)), name: .didTodaysDateChange, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .didCompleteModule, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didTodaysDateChange, object: nil)
    }
    
    @objc func onDidCompleteModule(_ notification:Notification) {
        let sender = notification.object
        // We only want to process notifications when sent by the object of type AuthorizedUser
        if let trackingModule = sender as? Modules {
            var name = ""
            var color = UIColor.black
            
            switch trackingModule {
            case .Omega3:
                name = "Omega 3"
                color = omega3Bar.colorTheme
            case .VitaminD:
                name = "Vitamin D"
                color = vitaminDBar.colorTheme
                break;
            case .Exercise:
                name = "Exercise"
                color = exerciseBar.colorTheme
                break
            case .Meditation:
                name = "Meditation"
                color = meditationBar.colorTheme
            case .Medication:
                name = "Medication"
                color = medicationBar.colorTheme
            }
            let message = "You Completed \(name). Great Work!"
            header.displayTrackingMessage(colorTheme: color, message: message)
        }
        
//        // userInfo is the payload send by sender of notification
//        if let userInfo = notification.userInfo {
//            // Safely unwrap the name sent out by the notification sender
//            if let userName = userInfo["Module"] as? String {
//                let message = "You Completed \(userName). Great Work!"
//                switch userName {
//                case "VitaminD":
//                    header.displayTrackingMessage(colorTheme: vitaminDBar.colorTheme, message: message)
//                    break;
//                default:
//                    break;
//                }
//            }
//        }

    }
    
    @objc func onTodaysDateChanged(_ notification:Notification) {
        print("todays date changed")
        //this will currently change the current date if you open the app and left off somewhere else, consider setting a bool and doing it on finished showing if currently hidden, or simply soft restart the app
        globalCurrentFullDate = omsDateFormatter.todaysFullDate
        loadCurrentDayUI()
    }
    
    func attemptMenuRestore() {
            header.stopRestoreThread()
            header.startRestoreThread()
    }
    
    //TODO: Consider changing to view will appear, and initialize TodaysData should be handled everytime the app enters the foreground
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
        
        _ = omsDateFormatter.todaysDate
        
        if let currentTrackingDay = TrackingModulesDBS().getTrackingDay(date: globalCurrentDate) {
            updatePageUI(currentTrackingDay)
        }
        else{
            print("Do something for days that were not tracked")
            OMSDateAccessor().createDay(date: globalCurrentDate)
            loadCurrentDayUI()
        }
        
        attemptMenuRestore()
    }
    
    private func updatePageUI(_ currentTrackingDay: TrackingDayDBT) {
        if globalCurrentDate == todaysDate {
            dateLog.text = "Today, \(OMSDateAccessor.getStyledDate(date: currentTrackingDay.DateCreated))"
        }
        else {
            dateLog.text = OMSDateAccessor.getStyledDate(date: currentTrackingDay.DateCreated)
        }
        //dateLog.text = currentTrackingDay.DateCreated
        
        //TODO make a way to get the proper description for each
        //FoodEatenRating is 1 - 5
        foodBar.setRightLabel(description: ProgressBarConfig.getfoodDescription(rating: currentTrackingDay.FoodEatenRating))
        omega3Bar.updateProgress()
        vitaminDBar.updateProgress()
        exerciseBar.updateProgress()
        meditationBar.updateProgress()
        medicationBar.updateProgress()
    }
    
    //MARK: Delegates
    
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
        case 5:
            let vc = QuickCompleteFoodVC()
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
            vc.theme = meditationBar.colorTheme
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
        case 5:
            let vc = FoodModuleVC()
            vc.modalPresentationStyle = .overCurrentContext
            vc.dismissalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            
            loadCurrentDayUI()
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
//        omsDateFormatter.progressDay()
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
        vc.theme = UIColor(red: 166 / 255.0, green: 69 / 255.0, blue: 210 / 255.0, alpha: 1.0)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func settingsPressed() {
        
    }
    
}
