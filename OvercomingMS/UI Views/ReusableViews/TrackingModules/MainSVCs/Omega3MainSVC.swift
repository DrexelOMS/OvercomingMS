//
//  ExerciseMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class Omega3MainSVC: MainAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    let button1 = AddCircleButton()
    let button2 = SupplementCircleButton()
    
    let omega3History : Omega3HistoryDBS = Omega3HistoryDBS()
    
    override func customSetup() {
        
    }
    
    //must be called by 
    override func initialize(parentVC: TrackingModuleAbstractVC) {
        super.initialize(parentVC: parentVC)
        
        button1.buttonAction = addButtonPressed
        button2.buttonAction = supplementButtonPressed
        
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
        totalsCountLabel.text = String(omega3History.getTotalGrams())
        totalsTextLabel.text = "Grams\nToday"
    }
    
    func addButtonPressed() {
        parentVC.pushSubView(newSubView: Omega3AddSVC())
    }
    
    func supplementButtonPressed() {
        //parentVC.pushSubView(newSubView: ExerciseStopwatchSVC())
        omega3History.addOmega3Item(supplementName: "Test", StartTime: Date(), Amount: 5)
        parentVC.updateProgressBar()
        reload()
    }
    
    override func updateColors() {
        button1.colorTheme = parentVC.theme
        button2.colorTheme = parentVC.theme
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return omega3History.getTodaysOmega3Items()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! Routine3PartCell
        
        cell.labelLeft.text = omega3History.getTodaysOmega3Items()![indexPath.row].supplementName
        let startTime = omega3History.getTodaysOmega3Items()![indexPath.row].StartTime
        cell.labelCenter.text = OMSDateAccessor.getDateTime(date: startTime)
        cell.labelRight.text =  "\(omega3History.getTodaysOmega3Items()![indexPath.row].Amount) grams."
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let omega3ItemSVC = Omega3Sele()
//        exerciseItemSVC.exerciseItem = exerciseRoutines.getTodaysExerciseItems()![indexPath.row]
//        exerciseItemSVC.parentVC = parentVC
//        parentVC.pushSubView(newSubView: exerciseItemSVC)
    }

}
