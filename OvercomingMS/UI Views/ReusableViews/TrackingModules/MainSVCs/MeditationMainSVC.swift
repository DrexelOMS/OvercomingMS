//
//  ExerciseMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class MeditationMainSVC: MainAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    let button1 = AddCircleButton()
    let button2 = TimerCircleButton()
    let button3 = GuidedCircleButton()
    
    let meditationHistory : MeditationHistoryDBS = MeditationHistoryDBS()
    
    override func customSetup() {
        
    }
    
    //must be called by 
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        button1.buttonAction = addButtonPressed
        button2.buttonAction = timerButtonPressed
        button3.buttonAction = guidedButtonPressed
        
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.addArrangedSubview(button2)
        buttonStackView.addArrangedSubview(button3)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        internetPopupButton.url = "https://overcomingms.org/recovery-program/meditation/"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        
        reload()
    }
    
    override func reload(){
        tableView.reloadData()
        
        
        let count = meditationHistory.getTodaysMeditationItems()?.count ?? 0
        if count <= 0 {
            tableView.setEmptyView(title: "No meditation items yet!" , message: "Select a button below to begin.")
        }
        else {
            tableView.restore()
        }
        
        totalsCountLabel.text = String(meditationHistory.getTotalMinutes())
        totalsTextLabel.text = "Minutes\nToday"
    }
    
    func addButtonPressed() {
        parentVC.pushSubView(newSubView: MeditationModifySVC())
    }
    
    func timerButtonPressed() {
        parentVC.pushSubView(newSubView: MeditationTimerModifySVC())
    }
    
    func guidedButtonPressed() {
        parentVC.pushSubView(newSubView: MeditationTimerSetupSVC())
    }
    
    override func updateColors() {
        button1.colorTheme = parentVC.theme
        button2.colorTheme = parentVC.theme
        button3.colorTheme = parentVC.theme
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meditationHistory.getTodaysMeditationItems()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! Routine3PartCell

        cell.labelLeft.text = meditationHistory.getTodaysMeditationItems()![indexPath.row].MeditationType
        let startTime = meditationHistory.getTodaysMeditationItems()![indexPath.row].StartTime
        cell.labelCenter.text = OMSDateAccessor.getDateTime(date: startTime)
        cell.labelRight.text =  "\(meditationHistory.getTodaysMeditationItems()![indexPath.row].minutes) \(ProgressBarConfig.lengthUOM)"

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meditationItemSVC = MeditationSelectedItemSVC()
        meditationItemSVC.meditationItem = meditationHistory.getTodaysMeditationItems()![indexPath.row]
        meditationItemSVC.parentVC = parentVC
        parentVC.pushSubView(newSubView: meditationItemSVC)
    }

}
