//
//  ExerciseMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class MedicationMainSVC: MainAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    let medicationCellName = "MedicationCell"
    let savedMedications = SavedMedicationDBS()
    
    let button1 = AddCircleButton()
    
    override func customSetup() {
        
    }
    
    //must be called by 
    override func initialize(parentVC: TrackingModuleAbstractVC) {
        super.initialize(parentVC: parentVC)
        
        button1.buttonAction = addButtonPressed
        
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        tableView.delegate = self
        tableView.dataSource = self
        
        //TODO make a new UI for this cell
        tableView.register(UINib(nibName: medicationCellName, bundle: nil), forCellReuseIdentifier: medicationCellName)
        
        reload()
    }
    
    override func reload(){
        tableView.reloadData()
        //totalsCountLabel.text = String(meditationHistory.getTotalMinutes())
        //totalsTextLabel.text = "Minutes\nToday"
    }
    
    func addButtonPressed() {
        //MeditationHistoryDBS().addMeditationItem(routineType: "Guided", startTime: Date(), endTime: Date().addingTimeInterval(60*5))
        parentVC.pushSubView(newSubView: MedicationAddSVC())
    }
    
    override func updateColors() {
        button1.colorTheme = parentVC.theme
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMedications.getSavedMedicationItems()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: medicationCellName, for: indexPath) as! MedicationCell
        
        let item = savedMedications.getSavedMedicationItems()![indexPath.row]
        
        cell.timeLabel.text = OMSDateAccessor.getDateTime(date: item.TimeOfDay)
        cell.nameLabel.text = item.MedicationName
        cell.amountLabel.text = "\(item.MedicationAmount) \(item.MedicationUOM)"
        cell.doneCheckButton.IsDone = false // this will need to use another DBS method
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let exerciseItemSVC = ExerciseSelectedItemSVC()
        //exerciseItemSVC.exerciseItem = exerciseRoutines.getTodaysExerciseItems()![indexPath.row]
        //exerciseItemSVC.parentVC = parentVC
        //parentVC.pushSubView(newSubView: exerciseItemSVC)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }

}
