//
//  ExerciseSelectedItem.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class Omega3SelectedItemSVC : SelectedItemSVC {
    
    var omega3Item : Omega3HistoryDBT!
    {
        didSet {
            reload()
        }
    }
    
    override func customSetup() {
        super.customSetup()
        
        topSubLabel.text = "Name"
        middleSubLabel.text = "Time"
        bottomSubLabel.text = "Amount"
    }

    override func reload() {
        topMainLabel.text = omega3Item.supplementName
        middleMainLabel.text = OMSDateAccessor.getDateTime(date: omega3Item.StartTime)
        bottomMainLabel.text = "\(omega3Item.Amount) \(ProgressBarConfig.omega3UOM)"
    }
    
    override func editButtonPressed() {
        let editPage = Omega3ModifySVC()
        editPage.editingOmega3Item = omega3Item
        parentVC.pushSubView(newSubView: editPage)
    }
    
    override func repeatButtonPressed() {
        let repeatPage = ConfirmationFactory.RepeatConfirmation()
        repeatPage.methodToRunOnConfirm = repeatItem
        repeatPage.resetToDefault = true
        parentVC.pushSubView(newSubView: repeatPage)
    }
    
    func repeatItem() {
        let newItem = Omega3HistoryDBT()
        newItem.supplementName = omega3Item.supplementName
        newItem.StartTime = Date()
        newItem.Amount = omega3Item.Amount
        Omega3HistoryDBS().addItem(item: newItem)
    }
    
    
    override func deleteButtonPressed() {
        let deletePage = ConfirmationFactory.DeleteConfirmation()
        deletePage.methodToRunOnConfirm = deleteItem
        deletePage.resetToDefault = true
        parentVC.pushSubView(newSubView: deletePage)
    }
    
    func deleteItem(){
       Omega3HistoryDBS().deleteItem(item: omega3Item)
    }
}
