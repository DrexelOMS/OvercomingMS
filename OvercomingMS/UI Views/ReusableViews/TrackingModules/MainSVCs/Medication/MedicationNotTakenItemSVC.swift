//
//  MedicationCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MedicationNotTakenItemSVC : CustomView {
    
    override var nibName: String {
        get {
            return "MedicationNotTakenItemSVC"
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet private weak var WeekdaysLabel: UILabel!
    
    var parentVC : SlidingStackVC!
    let savedMedications = SavedMedicationDBS()
    
    var item: SavedMedicationDBT!
    {
        didSet {
            updateStyle()
        }
    }
    
    override func customSetup() {
    }
    
    func updateStyle() {
        nameLabel.text = item.MedicationName
        amountLabel.text = "\(item.MedicationAmount) \(item.MedicationUOM)"
        
        WeekdaysLabel.attributedText = MedicationRateModel(rateString: item.Frequency).attributedString()
    }
    
}

