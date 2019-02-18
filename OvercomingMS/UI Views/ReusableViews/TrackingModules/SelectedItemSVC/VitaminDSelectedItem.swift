//
//  ExerciseSelectedItem.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class VitaminDSelectedItemSVC : SelectedItemSVC {
    
    var vitaminDItem : VitaminDHistoryDBT!
    {
        didSet {
            reload()
        }
    }
    
    enum ModifyMode {case Supplement, Outside}
    
    var fourthSL = SelectedLabelsSVC(mainLabel: "test1", subLabel: "test2")
    
    override func customSetup() {
        super.customSetup()
        
        topSubLabel.text = "Type"
        middleSubLabel.text = "Time"
        bottomSubLabel.text = "Amount"
    }
    
    override func updateColors() {
        //Update color themes
    }
    
    override func reload() {
        fourthSL.removeFromSuperview()
        if vitaminDItem.IsOutsideType {
            labelsStackView.addArrangedSubview(fourthSL)
            labelsStackView.translatesAutoresizingMaskIntoConstraints = false
            
            bottomSubLabel.text = "Length"
            bottomMainLabel.text = "\(vitaminDItem.minutes) \(ProgressBarConfig.lengthUOM)"
            
            fourthSL.mainLabel.text = "\(vitaminDItem.calculatedAmount) \(ProgressBarConfig.vitaminDUOM)"
            fourthSL.subLabel.text = "klU Conversion"
            
            labelsStackView.addArrangedSubview(fourthSL)
            labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        }
        else {
            bottomSubLabel.text = "Amount"
            bottomMainLabel.text = "\(vitaminDItem.calculatedAmount) \(ProgressBarConfig.vitaminDUOM)"
        }
        
        topMainLabel.text = vitaminDItem.VitaminDType
        middleMainLabel.text = OMSDateAccessor.getDateTime(date: vitaminDItem.StartTime)
    }
    
    override func editButtonPressed() {
        let editPage = VitaminDEditSVC()
        editPage.editingVitamindDItem = vitaminDItem
        parentVC.pushSubView(newSubView: editPage)
    }
    
    override func repeatButtonPressed() {
        let repeatPage = RepeatConfirmationSVC(methodToRunOnConfirm: repeatItem, resetToDefault: true)
        parentVC.pushSubView(newSubView: repeatPage)
    }
    
    func repeatItem() {
        if !vitaminDItem.IsOutsideType {
            
            VitaminDHistoryDBS().addVitaminDSupplementItem(vitaminDType: vitaminDItem.VitaminDType, startTime: Date(), vitaminDAmount: vitaminDItem.Amount)
        }
        else {
            let startTime = Date()
            let endTime = startTime.addingTimeInterval(TimeInterval(vitaminDItem.minutes * 60))
            VitaminDHistoryDBS().addVitaminDOutsideItem(vitaminDType: vitaminDItem.VitaminDType, startTime: startTime, endTime: endTime)
        }
    }
    
    
    override func deleteButtonPressed() {
        let deletePage = DeleteConfirmationSVC(methodToRunOnConfirm: deleteItem, resetToDefault: true)
        parentVC.pushSubView(newSubView: deletePage)
    }
    
    func deleteItem(){
       VitaminDHistoryDBS().deleteVitaminDItem(item: vitaminDItem)
    }
}
