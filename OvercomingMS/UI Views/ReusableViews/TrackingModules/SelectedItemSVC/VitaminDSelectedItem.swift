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
    
    override func customSetup() {
        super.customSetup()
        
        topSubLabel.text = "Type"
        middleSubLabel.text = "Time"
        bottomSubLabel.text = "Amount"
    }
 
    override func reload() {
        bottomMainLabel.text = "\(vitaminDItem.Amount) \(ProgressBarConfig.vitaminDUOM)"
        topMainLabel.text = vitaminDItem.VitaminDType
        middleMainLabel.text = OMSDateAccessor.getDateTime(date: vitaminDItem.StartTime)
    }
    
    override func editButtonPressed() {
        let editPage = VitaminDModifySVC()
        editPage.editingVitamindDItem = vitaminDItem
        parentVC.pushSubView(newSubView: editPage)
    }
    
    override func repeatButtonPressed() {
        let repeatPage = ConfirmationFactory.RepeatConfirmation()
        repeatPage.methodToRunOnConfirm = repeatItem
        repeatPage.resetToDefault = true
        parentVC.pushSubView(newSubView: repeatPage)
    }
    
    func repeatItem() {
        VitaminDHistoryDBS().addVitaminDItem(vitaminDType: vitaminDItem.VitaminDType, startTime: Date(), vitaminDAmount: vitaminDItem.Amount)
    }
    
    
    override func deleteButtonPressed() {
        let deletePage = ConfirmationFactory.DeleteConfirmation()
        deletePage.methodToRunOnConfirm = deleteItem
        deletePage.resetToDefault = true
        parentVC.pushSubView(newSubView: deletePage)
    }
    
    func deleteItem(){
       VitaminDHistoryDBS().deleteVitaminDItem(item: vitaminDItem)
    }
}
