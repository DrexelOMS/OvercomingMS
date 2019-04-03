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
    @IBOutlet weak var WeekdaysLabel: UILabel!
    
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
//        nameLabel.text = item.MedicationName
//        amountLabel.text = "\(item.MedicationAmount) \(item.MedicationUOM)"
//        doneCheckButton.IsDone = savedMedications.wasTaken(item: item)
//        doneCheckButton.isUserInteractionEnabled = savedMedications.isTrackedToday(item: item)
//        
//        if doneCheckButton.IsDone {
//            nameLabel.textColor = UIColor.lightGray
//            amountLabel.textColor = UIColor.lightGray
//            let attrString = NSAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
//            nameLabel.attributedText = attrString
//
//        }
//        else {
//            nameLabel.textColor = UIColor.black
//            amountLabel.textColor = UIColor.black
//            let attrString = NSAttributedString(string: nameLabel.text!)
//            nameLabel.attributedText = attrString
//        }
//        
//        if(!doneCheckButton.isUserInteractionEnabled){
//            backgroundColor = UIColor.lightGray
//            backgroundColor?.withAlphaComponent(0.5)
//        }
//        else {
//            backgroundColor = UIColor.clear
//            backgroundColor?.withAlphaComponent(1.0)
//        }
    }
    
}

