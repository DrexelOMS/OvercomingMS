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
        
        let myString = NSMutableAttributedString(string: "SMTWRFS")
        
        var myRange = NSRange(location: 1, length: 1)
        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: myRange)
        
        myRange = NSRange(location: 3, length: 1)
        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: myRange)
        
        myRange = NSRange(location: 5, length: 1)
        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: myRange)
        WeekdaysLabel.attributedText = myString
    }
    
}

