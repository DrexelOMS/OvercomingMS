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
    
    let button1 = CircleButtonFactory.AddButton()
    let button2 = CircleButtonFactory.SupplementButton()
    
    let omega3History : Omega3HistoryDBS = Omega3HistoryDBS()
    
    override func customSetup() {
        
    }
    
    //must be called by 
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        button1.buttonAction = addButtonPressed
        button2.buttonAction = supplementButtonPressed
        
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.addArrangedSubview(button2)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        
        internetPopupButton.descriptionLabel.text = "Learn more about why Omega-3 is important for a healthier you!"
        internetPopupButton.url = "https://overcomingms.org/recovery-program/diet/"
        
        reload()
    }
    
    override func reload(){
        tableView.reloadData()
        
        let count = omega3History.getTodaysOmega3Items()?.count ?? 0
        if count <= 0 {
            tableView.setEmptyView(message: "No entries yet!")
        }
        else {
            tableView.restore()
        }
        
        totalsCountLabel.text = String(omega3History.getTotalGrams())
        totalsTextLabel.text = "Grams\nToday"
    }
    
    func addButtonPressed() {
        parentVC.pushSubView(newSubView: Omega3ModifySVC())
    }
    
    func supplementButtonPressed() {
        let page = Omega3ModifySVC()
        page.isSupplementPage = true
        parentVC.pushSubView(newSubView: page)
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
        
        let items = omega3History.getTodaysOmega3Items()!
        
        cell.labelLeft.text = items[indexPath.row].supplementName
        let startTime = items[indexPath.row].StartTime
        cell.labelCenter.text = OMSDateAccessor.getDateTime(date: startTime)
        cell.labelRight.text =  "\(items[indexPath.row].Amount) \(ProgressBarConfig.omega3UOM)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let omega3ItemSVC = Omega3SelectedItemSVC()
        omega3ItemSVC.omega3Item = omega3History.getTodaysOmega3Items()![indexPath.row]
        omega3ItemSVC.parentVC = parentVC
        parentVC.pushSubView(newSubView: omega3ItemSVC)
    }

}
