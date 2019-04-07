//
//  MeditationSelectedItemSVC.swift
//  OvercomingMS
//
//  Created by Chris on 3/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationSelectedItemSVC: SelectedItemSVC {
    var meditationItem : MeditationHistoryDBT!
        
        {
        didSet {
            reload()
        }
    }
    
    override func customSetup() {
        super.customSetup()
        
        topSubLabel.text = "Type"
        middleSubLabel.text = "Time"
        bottomSubLabel.text = "Length"
    }
    
    override func reload() {
        topMainLabel.text = meditationItem.MeditationType
        middleMainLabel.text = OMSDateAccessor.getDateTime(date: meditationItem.StartTime)
        bottomMainLabel.text = "\(meditationItem.minutes) \(ProgressBarConfig.lengthUOM)"
    }
    
    override func editButtonPressed() {
        let editPage = MeditationModifySVC()
        editPage.editingMeditationItem = meditationItem
        parentVC.pushSubView(newSubView: editPage)
    }
    
    override func repeatButtonPressed() {
        let repeatPage = RepeatConfirmationSVC(methodToRunOnConfirm: repeatItem, resetToDefault: true)
        parentVC.pushSubView(newSubView: repeatPage)
    }
    
    func repeatItem() {
        let type = meditationItem.MeditationType
        let startTime = Date()
        let endTime = startTime.addingTimeInterval(TimeInterval(meditationItem.minutes * 60))
        MeditationHistoryDBS().addMeditationItem(routineType: type, startTime: startTime, endTime: endTime)
    }
    
    
    override func deleteButtonPressed() {
        let deletePage = DeleteConfirmationSVC(methodToRunOnConfirm: deleteItem, resetToDefault: true)
        parentVC.pushSubView(newSubView: deletePage)
    }
    
    func deleteItem(){
        MeditationHistoryDBS().deleteMeditationItem(item: meditationItem)
    }
}

