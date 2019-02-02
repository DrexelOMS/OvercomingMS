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

    override var nibName: String {
        get {
            return "ExerciseMainSVC"
        }
    }
    
    let button1 = AddCircleButton()
    let button2 = TimerCircleButton()
    
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
        
        reload()
    }
    
    override func reload(){
        tableView.reloadData()
        totalsCountLabel.text = String(exerciseVC.getTotalMinutes())
        totalsTextLabel.text = "Minutes\nToday"
    }
    
    func addButtonPressed() {
        //parentVC.pushSubView(newSubView: ExerciseMainSVC())
        print("Adding 5 Minute Test Routine")
        exerciseVC?.addDataItem()
    }
    
    func timerButtonPressed() {
        parentVC.pushSubView(newSubView: ConfirmationSVC())
    }
    
    override func updateColors() {
        button1.colorTheme = parentVC.theme
        button2.colorTheme = parentVC.theme
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseVC.getExerciseItems()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! Routine3PartCell
        
        cell.labelLeft.text = exerciseVC.getExerciseItems()![indexPath.row].RoutineType
        let startTime = exerciseVC.getExerciseItems()![indexPath.row].StartTime
        cell.labelCenter.text = OMSDateAccessor.getDateTime(date: startTime)
        cell.labelRight.text =  "\(exerciseVC.getExerciseItems()![indexPath.row].minutes) min."
        
        return cell
    }

}
