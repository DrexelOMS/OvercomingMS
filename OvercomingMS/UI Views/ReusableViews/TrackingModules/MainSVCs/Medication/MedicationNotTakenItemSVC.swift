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
        self.contentView?.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewPressed(tapGestureRecognizer: )))
        self.contentView?.addGestureRecognizer(tapGesture)
    }
    
    func updateStyle() {
        nameLabel.text = item.MedicationName
        amountLabel.text = "\(item.MedicationNote)"
        
        WeekdaysLabel.attributedText = MedicationRateModel(rateString: item.Frequency).attributedString()
    }
    
    @objc func viewPressed(tapGestureRecognizer: UITapGestureRecognizer) {
        let medicationItemSVC = MedicationSelectedItemSVC()
        medicationItemSVC.savedMedicationItem = item
        medicationItemSVC.parentVC = parentVC
        parentVC.pushSubView(newSubView: medicationItemSVC)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        contentView?.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        contentView?.backgroundColor = UIColor.gray
    }
    
}

