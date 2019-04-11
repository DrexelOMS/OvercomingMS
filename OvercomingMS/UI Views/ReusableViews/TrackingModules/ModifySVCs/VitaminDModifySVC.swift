//
//  ExerciseModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class VitaminDModifySVC : ModifyAbstractSVC {
    
    let vitaminDHistory = VitaminDHistoryDBS()
    
    var isSupplementPage: Bool = false {
        didSet {
            if isSupplementPage {
                if let type = defaults.value(forKey: VITAMIND_SUPPLEMENT_NAME_UD) as? String {
                    selectedType = type
                }
                if let amount = defaults.value(forKey: VITAMIND_SUPPLEMENT_AMOUNT_UD) as? Int {
                    selectedAmount = amount
                }
            }
        }
    }
    
    let defaults = UserDefaults.standard
    
    let VITAMIND_SUPPLEMENT_NAME_UD = "VitaminDSupplementName"
    let VITAMIND_SUPPLEMENT_AMOUNT_UD = "VitaminDSupplementAmount"
    
    var selectedType : String? {
        get {
            return vitaminDTypeTFI.selectedType
        }
        set {
            vitaminDTypeTFI.selectedType = newValue
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
    
    var vitaminDTypeTFI = TypeTFIFactory.VitaminDTypeTFI()
    var dateTimeTFI = DateTimeTFI()
    var amountTFI = AmountTFI(uom: ProgressBarConfig.vitaminDUOM)
    
    var editingVitamindDItem: VitaminDHistoryDBT! {
        didSet {
            selectedType = editingVitamindDItem.VitaminDType
            selectedStartTime = editingVitamindDItem.StartTime
            selectedAmount = editingVitamindDItem.Amount
        }
    }
    
    override func customSetup() {
        //set the initial text and start time of the textField
        selectedStartTime = Date()
        
        textInputStackView.addArrangedSubview(vitaminDTypeTFI)
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
            
            if editingVitamindDItem == nil {
                if isSupplementPage {
                    saveSupplementQuery(name: type, amount: amount)
                }
                
                vitaminDHistory.addVitaminDItem(vitaminDType: type, startTime: startTime, vitaminDAmount: amount)
            }
            else {
                let newItem = VitaminDHistoryDBT()
                newItem.VitaminDType = type
                newItem.StartTime = startTime
                newItem.Amount = amount
                
                vitaminDHistory.updateVitaminDItem(oldItem: editingVitamindDItem, newItem: newItem)
            }
            parentVC.reload();
            parentVC.resetToDefaultView()
            
        }
        
    }
    
    func saveSupplementQuery(name: String, amount: Int) {
        defaults.set(name, forKey: VITAMIND_SUPPLEMENT_NAME_UD)
        defaults.set(amount, forKey: VITAMIND_SUPPLEMENT_AMOUNT_UD)
    }
    
}
