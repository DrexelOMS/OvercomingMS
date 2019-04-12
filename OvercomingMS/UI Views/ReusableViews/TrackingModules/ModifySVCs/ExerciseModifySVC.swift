//
//  ExerciseModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class ExerciseModifySVC : ModifyAbstractSVC {
    
    let exerciseHistory = ExerciseHistoryDBS()
    
    var selectedType : String? {
        get {
            return typeTFI.selectedType
        }
        set {
            typeTFI.selectedType = newValue
        }
    }
    var selectedStartTime : Date? {
        get {
            return dateTimeTFI.selectedStartTime
        }
        set {
            dateTimeTFI.selectedStartTime = newValue
        }
    }
    var selectedLength : Int?  { // In minutes
        get {
            return lengthTFI.selectedLength
        }
        set {
            lengthTFI.selectedLength = newValue
        }
    }
    
    var typeTFI = TypeTFIFactory.ExerciseTypeTFI()
    var dateTimeTFI = DateTimeTFI()
    var lengthTFI = LengthTFI()
    
    var editingExerciseItem : ExerciseHistoryDBT!{
        didSet {
            selectedType = editingExerciseItem.RoutineType
            
            selectedStartTime = editingExerciseItem.StartTime
            
            selectedLength = editingExerciseItem.minutes
        }
    }
    
    override func customSetup() {
        //set the initial text and start time of the textField
        selectedStartTime = Date()
        
        textInputStackView.addArrangedSubview(typeTFI)
        textInputStackView.addArrangedSubview(dateTimeTFI)
        textInputStackView.addArrangedSubview(lengthTFI)
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
        
    }
    
    convenience init(startTime: Date, length: Int)
    {
        self.init()
        
        selectedStartTime = startTime
        selectedLength = length
    }
    
    override func ConfirmPressed() {
        
        if let type = selectedType, let startTime = selectedStartTime, let minutes = selectedLength {
            if minutes <= 0 {
                return;
            }
            
            let newItem = ExerciseHistoryDBT()
            newItem.RoutineType = type
            newItem.StartTime = startTime
            newItem.EndTime = startTime.addingTimeInterval(TimeInterval(minutes * 60))
            
            if editingExerciseItem == nil {
                exerciseHistory.addItem(item: newItem)
                
                parentVC.reload();
                parentVC.resetToDefaultView()
            }
            else {
                exerciseHistory.updateExerciseItem(oldItem: editingExerciseItem, newItem: newItem)
                
                parentVC.reload();
                parentVC.popSubView()
            }
        }
        
    }
    
}
