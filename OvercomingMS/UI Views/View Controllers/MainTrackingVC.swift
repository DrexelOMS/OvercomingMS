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
    
    var todaysDate : String {
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
    
    @IBOutlet weak var centerDateView: UIView!
    @IBOutlet weak var previousButton: UIView!
    @IBOutlet weak var nextDay: UIView!
    @IBOutlet weak var rightArrowButton: UIButton!
    @IBOutlet weak var leftArrowButton: UIButton!
    
    @IBOutlet weak var GoalButton: CircleButtonSVC!
    @IBOutlet weak var SymptomsButton: CircleButtonSVC!
    @IBOutlet weak var SettingsButton: CircleButtonSVC!

    private let omsDateFormatter = OMSDateAccessor()
    
    @IBOutlet weak var datePickerContainer: UIView!
    
    var notificationCenter = NotificationCenterWrapper()
    
    var onboardingVC: SlidingStackVC!
    //MARK: View Transition Initializers
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(onDidCompleteModule(_:)), name: .didCompleteModule, object: nil)
        notificationCenter.addObserver(self, selector: #selector(onTodaysDateChanged(_:)), name: .didTodaysDateChange, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationCenter.removeObserver(self, name: .didCompleteModule, object: nil)
        notificationCenter.removeObserver(self, name: .didTodaysDateChange, object: nil)
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
                name = "Omega-3"
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
    func onboardingCheck() {
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: "PlayedTutorialVideo") as? Bool != true {
            defaults.set(true, forKey: "PlayedTutorialVideo")
            
            onboardingVC = SlidingStackVC(initialView: WelcomePageSVC())
            onboardingVC.disableSwipe()
            onboardingVC.modalPresentationStyle = .overCurrentContext
            onboardingVC.theme = UIColor(red: 2, green: 162, blue: 182)
            onboardingVC.dismissalDelegate = self
                
            present(onboardingVC, animated: true, completion: nil)
        }
    }
    
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
        
        centerDateView.isUserInteractionEnabled = true
        let progressGesture = UITapGestureRecognizer(target: self, action: #selector(ProgressDayPressed(gesture: )))
        centerDateView.addGestureRecognizer(progressGesture)
        
        nextDay.isUserInteractionEnabled = true
        let nextGesture = UITapGestureRecognizer(target: self, action: #selector(nextDate(gesture: )))
        nextDay.addGestureRecognizer(nextGesture)

        GoalButton.buttonAction = goalPressed
        SymptomsButton.buttonAction = symptomsPressed
        SettingsButton.buttonAction = settingsPressed
        
        loadCurrentDayUI()
        
        DispatchQueue.main.async {
            self.onboardingCheck()
        }
        
    }
    
    private func loadCurrentDayUI() {
        
        _ = omsDateFormatter.todaysDate
        
        let currentTrackingDay = TrackingModulesDBS(editingDate: globalCurrentDate).getTrackingDay()
        updatePageUI(currentTrackingDay)
        
        attemptMenuRestore()
    }
    
    private func updatePageUI(_ currentTrackingDay: TrackingDayDBT) {
        if globalCurrentDate == todaysDate {
            dateLog.text = "Today, \(OMSDateAccessor.getStyledDate(date: currentTrackingDay.DateCreated))"
            rightArrowButton.isEnabled = false
        }
        else {
            dateLog.text = OMSDateAccessor.getStyledDate(date: currentTrackingDay.DateCreated)
            rightArrowButton.isEnabled = true
        }
        let date = UserDefaults.standard.object(forKey: "FirstOpenDate") as! Date
        leftArrowButton.isEnabled = !OMSDateAccessor().lessThanEqualComparison(left: globalCurrentFullDate, right: date)
        //dateLog.text = currentTrackingDay.DateCreated
        
        //TODO make a way to get the proper description for each
        //FoodEatenRating is 1 - 5
        let activeTracking = ActiveTrackingDBS()
        let recentItems = activeTracking.mostRecentActiveTracking
        foodBar.update(trackingDBS: FoodRatingDBS(), isTracked: recentItems.IsFoodActive)
        omega3Bar.update(trackingDBS: Omega3HistoryDBS(), isTracked: recentItems.IsOmega3Active)
        vitaminDBar.update(trackingDBS: VitaminDHistoryDBS(), isTracked: recentItems.IsVitaminDActive)
        exerciseBar.update(trackingDBS: ExerciseHistoryDBS(), isTracked: recentItems.IsExerciseActive)
        meditationBar.update(trackingDBS: MeditationHistoryDBS(), isTracked: recentItems.IsMeditationActive)
        medicationBar.update(trackingDBS: SavedMedicationDBS(), isTracked: recentItems.IsMedicationActive)
        
        let streak = TrackingModulesDBS().getTotalPerfectDays()
        var plural = ""
        if streak != 1 {
            plural = "s"
        }
        
        header.perfectDaysLabel.text = "\(TrackingModulesDBS().getTotalPerfectDays()) great day\(plural)!"
        setHeaderStreak()

    }
    
    private func setHeaderStreak() {
        var count = 0
        var date = globalCurrentDate
        
        //Start counting from yesterday
        let previousDay = OMSDateAccessor.getFullDate(date: date).addingTimeInterval(-60*60*24)
        date = OMSDateAccessor.getFormatedDate(date: previousDay)
        while(TrackingModulesDBS(editingDate: date).getTrackingDay().IsDayComplete) {
            count += 1
            
            let previousDay = OMSDateAccessor.getFullDate(date: date).addingTimeInterval(-60*60*24)
            date = OMSDateAccessor.getFormatedDate(date: previousDay)
        }
        
        //add 1 if they actually completed today
        if(TrackingModulesDBS(editingDate: globalCurrentDate).getTrackingDay().IsDayComplete) {
            count += 1
        }
        
        header.daysInARow.text = "\(count) in a row!"
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
    
    var moduleVC: SlidingStackVC!
    
    func didPressLeftContainer(_ sender: TrackingProgressBar) {
        
        
        switch(sender.tag){
        case 0:
            moduleVC = TrackingModuleFactory.Omega3VC()
            break
        case 1:
            moduleVC = TrackingModuleFactory.VitaminDVC()
            break
        case 2:
            moduleVC = TrackingModuleFactory.ExerciseVC()
            break
        case 3:
            moduleVC = TrackingModuleFactory.MeditationVC()
            break
        case 4:
            moduleVC = TrackingModuleFactory.MedicationVC()
            break
        case 5:
            moduleVC = FoodModuleVC(initialView: FoodMainSVC())
            break
        default:
            fatalError("Case Not Handled")
            break;
        }
        
        moduleVC.theme = sender.colorTheme
        moduleVC.modalPresentationStyle = .overCurrentContext
        moduleVC.dismissalDelegate = self
        moduleProgressButtonHeight = Int(foodBar.frame.height)
        
        self.present(moduleVC, animated: true, completion: nil)
        
        //loadCurrentDayUI()
        
    }
    
    //MARK: IBActions

    @objc func previousDate(gesture: UIGestureRecognizer) {
        let date = UserDefaults.standard.object(forKey: "FirstOpenDate") as! Date
        if OMSDateAccessor().lessThanEqualComparison(left: globalCurrentFullDate, right: date) {
            return
        }
        globalCurrentFullDate = globalCurrentFullDate.addingTimeInterval(-60*60*24)
        loadCurrentDayUI()
    }
    
    @objc func nextDate(gesture: UIGestureRecognizer) {
        if globalCurrentDate == todaysDate {
            return
        }
        globalCurrentFullDate = globalCurrentFullDate.addingTimeInterval(60*60*24)
        loadCurrentDayUI()
    }
    
    var dataPicker: SlidingStackVC!
    var goalVC: SlidingStackVC!
    var symptomsVC: SlidingStackVC!
    var settingsVC: SlidingStackVC!
    
    @objc func ProgressDayPressed(gesture: UIGestureRecognizer) {
//        omsDateFormatter.progressDay()
        
        dataPicker = SlidingStackVC(initialView: DatePickerSVC())
        dataPicker.modalPresentationStyle = .overCurrentContext
        dataPicker.dismissalDelegate = self
        
        self.present(dataPicker, animated: true, completion: nil)
    }
    
    func goalPressed() {
        if globalCurrentDate == todaysDate {
            goalVC = TopImageSlidingStackVC(topImage: UIImage(named: "Goals")!, initialView: GoalsMainSVC())
            goalVC.modalPresentationStyle = .overCurrentContext
            goalVC.dismissalDelegate = self
            
            self.present(goalVC, animated: true, completion: nil)
        }
    }
    
    func symptomsPressed() {
        symptomsVC = TopImageSlidingStackVC(topImage: UIImage(named: "Symptoms")!, initialView: SymptomsMainSVC())
        symptomsVC.modalPresentationStyle = .overCurrentContext
        symptomsVC.dismissalDelegate = self
        symptomsVC.theme = UIColor(red: 166 / 255.0, green: 69 / 255.0, blue: 210 / 255.0, alpha: 1.0)
        
        self.present(symptomsVC, animated: true, completion: nil)
    }
    
    func settingsPressed() {
        settingsVC = TopImageSlidingStackVC(topImage: UIImage(named: "Settings")!, initialView: SettingsMainSVC())
        settingsVC.modalPresentationStyle = .overCurrentContext
        settingsVC.dismissalDelegate = self
        
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async{
            var rate = 1 - ((80 -  self.datePickerContainer.frame.height)) / 35
            rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
            
            let fontSize = 16 + (6) * rate
            
            self.dateLog.font = UIFont(name: self.dateLog.font.fontName, size: fontSize)
        }
    }
    
}
