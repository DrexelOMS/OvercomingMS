//
//  ExerciseMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class VitaminDMainSVC: MainAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    let button1 = AddCircleButton()
    let button2 = SupplementCircleButton()
    let button3 = OutsideCircleButton()
    
    let vitaminDHistory : VitaminDHistoryDBS = VitaminDHistoryDBS()
    
    override func customSetup() {
        
    }
    
    //must be called by 
    override func initialize(parentVC: SwipeDownCloseViewController) {
        super.initialize(parentVC: parentVC)
        
        button1.buttonAction = addButtonPressed
        button2.buttonAction = supplementButtonPressed
        button3.buttonAction = outsideButtonPressed
        
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.addArrangedSubview(button2)
        buttonStackView.addArrangedSubview(button3)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        
        reload()
    }
    
    override func reload(){
        tableView.reloadData()
        totalsCountLabel.text = String(vitaminDHistory.getTotalAmount())
        totalsTextLabel.text = "\(ProgressBarConfig.vitaminDUOM)\nToday"
    }
    
    func addButtonPressed() {
        parentVC.pushSubView(newSubView: VitaminDQuickAddSVC())
    }
    
    func supplementButtonPressed() {
        parentVC.pushSubView(newSubView: VitaminDSupplementSVC())
    }
    
    func outsideButtonPressed() {
        //parentVC.pushSubView(newSubView: Omega3SupplementSVC())
        print("Out")
    }
    
    override func updateColors() {
        button1.colorTheme = parentVC.theme
        button2.colorTheme = parentVC.theme
        button3.colorTheme = parentVC.theme
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vitaminDHistory.getTodaysVitaminDItems()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! Routine3PartCell
        
        let items = vitaminDHistory.getTodaysVitaminDItems()!
        
        cell.labelLeft.text = items[indexPath.row].VitaminDType
        let startTime = items[indexPath.row].StartTime
        cell.labelCenter.text = OMSDateAccessor.getDateTime(date: startTime)
        cell.labelRight.text =  "\(items[indexPath.row].Amount) \(ProgressBarConfig.vitaminDUOM)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vitaminDItemSVC = VitaminDSelectedItemSVC()
        vitaminDItemSVC.vitaminDItem = vitaminDHistory.getTodaysVitaminDItems()![indexPath.row]
        vitaminDItemSVC.parentVC = parentVC
        parentVC.pushSubView(newSubView: vitaminDItemSVC)
    }

}
