//
//  ExerciseMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography
import RealmSwift

class MedicationMainSVC: MainAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    let medicationCellName = "MedicationCell"
    let savedMedications = SavedMedicationDBS()
    
    let button1 = CircleButtonFactory.AddMedicationButton()
    
    let cellName = "ExpandingCell"
    
    //TODO apply proper calculations to get the list of nonTracked med items for the day
    //and tracked items for the day, and use count of tracked items + if (hasNontrackedItems} count += 1
    var hasNonTrackedItems: Bool {
        return savedMedications.getSavedMedicationItems().hasUntrackedMeds()
    }
    var tableCount: Int {
        get {
            var count = savedMedications.getSavedMedicationItems().medicationsTracked.count
            if hasNonTrackedItems {
                count += 1
            }
            return count
        }
    }
    
    override func customSetup() {
        topStackView.isHidden = true
        constrain(topStackView) { (view) in
            view.height == 0
        }
        button1.setEnabled(enabled: globalCurrentDate == OMSDateAccessor().todaysDate)
    }
    
    //must be called by 
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        button1.buttonAction = addButtonPressed
        
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        internetPopupButton.descriptionLabel.text = "Click here to learn more about this step"
        internetPopupButton.url = "https://overcomingms.org/recovery-program/drug-therapies/"

        tableView.delegate = self
        tableView.dataSource = self
        
        //TODO make a new UI for this cell
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        
        reload()
    }
    
    override func reload(){
        tableView.reloadData()
        
        
        let count = savedMedications.getSavedMedicationItems().getTotalMedCount()
        if count <= 0 {
            tableView.setEmptyView(title: "You haven’t added any medications yet!", message: "Press the “Add Medication” button to begin!")
        }
        else {
            tableView.restore()
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        //totalsCountLabel.text = String(meditationHistory.getTotalMinutes())
        //totalsTextLabel.text = "Minutes\nToday"
    }
    
    func addButtonPressed() {
        if globalCurrentDate == OMSDateAccessor().todaysDate {
            parentVC.pushSubView(newSubView: MedicationModifySVC())
        }
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
            
            for i in savedMedications.getSavedMedicationItems().medicationsNotTracked {
                let view = MedicationNotTakenItemSVC()
                view.item = i
                view.parentVC = parentVC
                cell.addToMiddle(view: view)
            }
            
            cell.hideBottomView()
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! ExpandingCell
        
            let item = savedMedications.getSavedMedicationItems().medicationsTracked[indexPath.row]
            
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

}
