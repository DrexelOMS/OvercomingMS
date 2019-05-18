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
    
    let button1 = CircleButtonFactory.AddButton()
    let button2 = CircleButtonFactory.SupplementButton()
    let button3 = CircleButtonFactory.OutsideButton()
    
    let vitaminDHistory : VitaminDHistoryDBS = VitaminDHistoryDBS()
    
    override func customSetup() {
        
    }
    
    //must be called by 
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        button1.buttonAction = addButtonPressed
        button2.buttonAction = supplementButtonPressed
        button3.buttonAction = outsideButtonPressed
        
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.addArrangedSubview(button2)
        buttonStackView.addArrangedSubview(button3)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        internetPopupButton.descriptionLabel.text = "Learn more about the importance of Vitamin D here!"
        internetPopupButton.url = "https://overcomingms.org/recovery-program/sunlight-vitamin-d/"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        
        reload()
    }
    
    override func reload(){
        tableView.reloadData()
        
        let count = vitaminDHistory.getTodaysVitaminDItems()?.count ?? 0
        if count <= 0 {
            tableView.setEmptyView(message: "No entries yet!")
        }
        else {
            tableView.restore()
        }
        
        totalsCountLabel.text = String(vitaminDHistory.getTotalAmount())
        totalsTextLabel.text = "\(ProgressBarConfig.vitaminDUOM)\nToday"
    }
    
    func addButtonPressed() {
        parentVC.pushSubView(newSubView: VitaminDModifySVC())
    }
    
    func supplementButtonPressed() {
        let supplementPage = VitaminDModifySVC()
        supplementPage.isSupplementPage = true
        parentVC.pushSubView(newSubView: supplementPage)
    }
    
    func outsideButtonPressed() {
        parentVC.pushSubView(newSubView: OutsideSVC())
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
