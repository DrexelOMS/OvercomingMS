//
//  ExerciseMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class ExerciseMainSVC: MainAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    let button1 = AddCircleButton()
    let button2 = TimerCircleButton()
    
    let exerciseHistory : ExerciseHistoryDBS = ExerciseHistoryDBS()
    
    override func customSetup() {
        
    }
    
    //must be called by 
    override func initialize(parentVC: TrackingModuleAbstractVC) {
        super.initialize(parentVC: parentVC)
        
        button1.buttonAction = addButtonPressed
        button2.buttonAction = timerButtonPressed
        
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.addArrangedSubview(button2)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        
        internetPopupButton.url = "https://overcomingms.org/recovery-program/exercise/exercises-for-all-levels/"
        
        reload()
    }
    
    override func reload(){
        tableView.reloadData()
        totalsCountLabel.text = String(exerciseHistory.getTotalMinutes())
        totalsTextLabel.text = "Minutes\nToday"
    }
    
    func addButtonPressed() {
        parentVC.pushSubView(newSubView: ExerciseAddSVC())
    }
    
    func timerButtonPressed() {
        parentVC.pushSubView(newSubView: ExerciseStopwatchSVC())
    }
    
    override func updateColors() {
        button1.colorTheme = parentVC.theme
        button2.colorTheme = parentVC.theme
    }
    
    //MARK: TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseHistory.getTodaysExerciseItems()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! Routine3PartCell
        
        let items = exerciseHistory.getTodaysExerciseItems()!
        
        cell.labelLeft.text = items[indexPath.row].RoutineType
        let startTime = items[indexPath.row].StartTime
        cell.labelCenter.text = OMSDateAccessor.getDateTime(date: startTime)
        cell.labelRight.text =  "\(items[indexPath.row].minutes) \(ProgressBarConfig.lengthUOM)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exerciseItemSVC = ExerciseSelectedItemSVC()
        exerciseItemSVC.exerciseItem = exerciseHistory.getTodaysExerciseItems()![indexPath.row]
        exerciseItemSVC.parentVC = parentVC
        parentVC.pushSubView(newSubView: exerciseItemSVC)
    }

}
