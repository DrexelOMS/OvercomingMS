//
//  TestTrackingViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/20/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MainTrackingVC: UIViewController, DismissalDelegate, TrackingProgressBarDelegate {
    
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
    @IBOutlet weak var foodBar: TrackingProgressBar!
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
            case .Food:
                name = "Food"
                color = foodBar.colorTheme
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

    }
    
    @objc func onTodaysDateChanged(_ notification:Notification) {
        print("todays date changed")
        //this will currently change the current date if you open the app and left off somewhere else, consider setting a bool and doing it on finished showing if currently hidden, or simply soft restart the app
        globalCurrentFullDate = omsDateFormatter.todaysFullDate
        loadCurrentDayUI()
    }
    
    var isPastDay = false
    
    func attemptMenuRestore() {
        if isPastDay {
            isPastDay = false
            header.restore()
        }
        header.stopRestoreThread()
        if globalCurrentDate == todaysDate {
            header.startRestoreThread()
            GoalButton.setEnabled(enabled: true)
        }
        else {
            isPastDay = true
            header.displayPreviousDateMessage()
            GoalButton.setEnabled(enabled: false)
        }
    }
    
    //TODO: Consider changing to view will appear, and initialize TodaysData should be handled everytime the app enters the foreground
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let currentTrackingDay = TrackingModulesDBS().getTrackingDay(date: globalCurrentDate)
        updatePageUI(currentTrackingDay)
        
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
        foodBar.update(trackingDBS: FoodRatingDBS())
        omega3Bar.update(trackingDBS: Omega3HistoryDBS())
        vitaminDBar.update(trackingDBS: VitaminDHistoryDBS())
        exerciseBar.update(trackingDBS: ExerciseHistoryDBS())
        meditationBar.update(trackingDBS: MeditationHistoryDBS())
        medicationBar.update(trackingDBS: SavedMedicationDBS())
        
        header.perfectDaysLabel.text = "\(TrackingModulesDBS().getTotalPerfectDays()) perfect days"
        
//        medicationBar.setEnabled(enabled: false)
    }
    
    //MARK: Delegates
    
    func didPressCheckButton(_ sender: TrackingProgressBar) {
        
        switch(sender.tag){
        case 0:
            Omega3HistoryDBS().addQuickCompleteItem()
            break
        case 1:
            VitaminDHistoryDBS().addQuickCompleteItem()
            break
        case 2:
            ExerciseHistoryDBS().addQuickCompleteItem()
            break
        case 3:
            MeditationHistoryDBS().addQuickCompleteItem()
            break
        case 4:
            SavedMedicationDBS().addQuickCompleteItem()
            break
        case 5:
            FoodRatingDBS().addQuickCompleteItem()
            break
        default:
            fatalError("Case Not Handled")
            break;
        }
        
        loadCurrentDayUI()
        
    }
    
    func didPressLeftContainer(_ sender: TrackingProgressBar) {
        
        var vc: SlidingStackVC
        
        switch(sender.tag){
        case 0:
            vc = TrackingModuleFactory.Omega3VC()
            break
        case 1:
            vc = TrackingModuleFactory.VitaminDVC()
            break
        case 2:
            vc = TrackingModuleFactory.ExerciseVC()
            break
        case 3:
            vc = TrackingModuleFactory.MeditationVC()
            break
        case 4:
            vc = TrackingModuleFactory.MedicationVC()
            break
        case 5:
            vc = SlidingStackVC(initialView: FoodMainSVC())
            break
        default:
            fatalError("Case Not Handled")
            break;
        }
        
        vc.theme = sender.colorTheme
        vc.modalPresentationStyle = .overCurrentContext
        vc.dismissalDelegate = self
        
        self.present(vc, animated: true, completion: nil)
        
        //loadCurrentDayUI()
        
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
    }
    
    func goalPressed() {
        if globalCurrentDate == todaysDate {
            let vc = TopImageSlidingStackVC(topImage: UIImage(named: "Goals")!, initialView: GoalsMainSVC())
            vc.modalPresentationStyle = .overCurrentContext
            vc.dismissalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func symptomsPressed() {
        let vc = TopImageSlidingStackVC(topImage: UIImage(named: "Symptoms")!, initialView: SymptomsMainSVC())
        vc.modalPresentationStyle = .overCurrentContext
        vc.dismissalDelegate = self
        vc.theme = UIColor(red: 166 / 255.0, green: 69 / 255.0, blue: 210 / 255.0, alpha: 1.0)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func settingsPressed() {
        let vc = TopImageSlidingStackVC(topImage: UIImage(named: "Settings")!, initialView: SettingsMainSVC())
        vc.modalPresentationStyle = .overCurrentContext
        vc.dismissalDelegate = self
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
