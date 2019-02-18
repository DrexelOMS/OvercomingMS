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
    var mode : ModifyMode = .Supplement {
        didSet {
            toggleMode()
        }
    }
    
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
        if vitaminDItem.IsOutsideType {
            mode = .Outside
        }
        else {
            mode = .Supplement
        }
        
        topMainLabel.text = vitaminDItem.VitaminDType
        middleMainLabel.text = OMSDateAccessor.getDateTime(date: vitaminDItem.StartTime)
        bottomMainLabel.text = "\(vitaminDItem.calculatedAmount) \(ProgressBarConfig.vitaminDUOM)"
    }
    
    func toggleMode(){
        
    }
    
    override func editButtonPressed() {
        //let editPage = VitaminDEditSVC()
        //editPage.editingOmega3Item = omega3Item
        //parentVC.pushSubView(newSubView: editPage)
    }
    
    override func repeatButtonPressed() {
        let repeatPage = RepeatConfirmationSVC(methodToRunOnConfirm: repeatItem, resetToDefault: true)
        parentVC.pushSubView(newSubView: repeatPage)
    }
    
    func repeatItem() {
        if mode == .Supplement {
            
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
