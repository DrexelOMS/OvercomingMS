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
    
    let cellName = "ExpandingCell"
    
    var hasNonTrackedItems = true
    var tableCount: Int {
        get {
            var count = savedMedications.getSavedMedicationItems()?.count ?? 0
            //if has nonTrackedMeds
            count += 1
            return count
        }
    }
    
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
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
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
        return tableCount

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if hasNonTrackedItems && indexPath.row == tableCount - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! ExpandingCell
            
            cell.clear()
            cell.topLabel.text = "Not Taking Today"
            let view = MedicationNotTakenItemSVC()
            cell.addToMiddle(view: view)
            
            cell.hideBottomView()
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! ExpandingCell
            
            let item = savedMedications.getSavedMedicationItems()![indexPath.row]
            let view = MedicationItemSVC()
            view.item = item
            view.parentVC = parentVC
            
            cell.clear()
            cell.addToMiddle(view: view)
            cell.hideBottomView()
            cell.topLabel.text =  OMSDateAccessor.getDateTime(date: item.TimeOfDay)
            
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let medicationItemSVC = MedicationSelectedItemSVC()
//        medicationItemSVC.savedMedicationItem = savedMedications.getSavedMedicationItems()![indexPath.row]
//        medicationItemSVC.parentVC = parentVC
//        parentVC.pushSubView(newSubView: medicationItemSVC)
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 80.0
//    }

}
