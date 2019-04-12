//
//  ExerciseModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class Omega3ModifySVC : ModifyAbstractSVC {
    
    let omega3History = Omega3HistoryDBS()
    
    var isSupplementPage: Bool = false {
        didSet {
            if isSupplementPage {
                if let type = defaults.value(forKey: OMEGA3_SUPPLEMENT_NAME_UD) as? String {
                    selectedType = type
                }
                if let amount = defaults.value(forKey: OMEGA3_SUPPLEMENT_AMOUNT_UD) as? Int {
                    selectedAmount = amount
                }
            }
        }
    }
    
    let defaults = UserDefaults.standard
    
    let OMEGA3_SUPPLEMENT_NAME_UD = "Omega3SupplementName"
    let OMEGA3_SUPPLEMENT_AMOUNT_UD = "Omega3SupplementAmount"
    
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
    var selectedAmount : Int?  { // In minutes
        get {
            return amountTFI.selectedAmount
        }
        set {
            amountTFI.selectedAmount = newValue
        }
    }
    
    var typeTFI = TypeTFIFactory.Omega3TypeTFI()
    var dateTimeTFI = DateTimeTFI()
    var amountTFI = AmountTFI(uom: ProgressBarConfig.omega3UOM)
    
    var editingOmega3Item : Omega3HistoryDBT!{
        didSet {
            selectedType = editingOmega3Item.supplementName
            selectedStartTime = editingOmega3Item.StartTime
            selectedAmount = editingOmega3Item.Amount
        }
    }
    
    override func customSetup() {
        //set the initial text and start time of the textField
        selectedStartTime = Date()
        
        textInputStackView.addArrangedSubview(typeTFI)
        textInputStackView.addArrangedSubview(dateTimeTFI)
        textInputStackView.addArrangedSubview(amountTFI)
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
        
    }
    
    override func ConfirmPressed() {
        
        if let type = selectedType, let startTime = selectedStartTime, let amount = selectedAmount {
            if amount <= 0 {
                return;
            }
            
            let newItem = Omega3HistoryDBT()
            newItem.supplementName = type
            newItem.StartTime = startTime
            newItem.Amount = amount
            
            if editingOmega3Item == nil {
                if isSupplementPage {
                    saveSupplementQuery(name: type, amount: amount)
                }
                
                omega3History.addItem(item: newItem)
                parentVC.reload();
                parentVC.resetToDefaultView()
            }
            else {
                
                omega3History.updateOmega3Item(oldItem: editingOmega3Item, newItem: newItem)
                parentVC.reload();
                parentVC.popSubView()
            }
        }
        
    }
    
    func saveSupplementQuery(name: String, amount: Int) {
        defaults.set(name, forKey: OMEGA3_SUPPLEMENT_NAME_UD)
        defaults.set(amount, forKey: OMEGA3_SUPPLEMENT_AMOUNT_UD)
    }

    
}
