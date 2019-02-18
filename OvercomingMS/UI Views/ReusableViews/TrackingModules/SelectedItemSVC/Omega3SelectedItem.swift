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
    
    override func updateColors() {
        //Update color themes
    }
    
    override func reload() {
        topMainLabel.text = omega3Item.supplementName
        middleMainLabel.text = OMSDateAccessor.getDateTime(date: omega3Item.StartTime)
        bottomMainLabel.text = "\(omega3Item.Amount) g."
    }
    
    override func editButtonPressed() {
        let editPage = Omega3EditSVC()
        editPage.editingOmega3Item = omega3Item
        parentVC.pushSubView(newSubView: editPage)
    }
    
    override func repeatButtonPressed() {
        let repeatPage = RepeatConfirmationSVC(methodToRunOnConfirm: repeatItem, resetToDefault: true)
        parentVC.pushSubView(newSubView: repeatPage)
    }
    
    func repeatItem() {
        let type = omega3Item.supplementName
        let startTime = Date()
        let amount = omega3Item.Amount
        Omega3HistoryDBS().addOmega3Item(supplementName: type, StartTime: startTime, Amount: amount)
    }
    
    
    override func deleteButtonPressed() {
        let deletePage = DeleteConfirmationSVC(methodToRunOnConfirm: deleteItem, resetToDefault: true)
        parentVC.pushSubView(newSubView: deletePage)
    }
    
    func deleteItem(){
       Omega3HistoryDBS().deleteOmega3Item(item: omega3Item)
    }
}
