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
        totalsView.isHidden = true
    }
    
    //must be called by 
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        button1.buttonAction = addButtonPressed
        
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        internetPopupButton.url = "https://overcomingms.org/recovery-program/drug-therapies/"

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
        
        cell.item = item
        cell.parentVC = parentVC
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let medicationItemSVC = MedicationSelectedItemSVC()
        medicationItemSVC.savedMedicationItem = savedMedications.getSavedMedicationItems()![indexPath.row]
        medicationItemSVC.parentVC = parentVC
        parentVC.pushSubView(newSubView: medicationItemSVC)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0
    }

}
