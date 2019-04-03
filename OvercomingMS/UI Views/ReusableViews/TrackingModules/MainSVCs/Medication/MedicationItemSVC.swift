//
//  MedicationCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MedicationItemSVC : CustomView {
    
    override var nibName: String {
        get {
            return "MedicationItemSVC"
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var doneCheckButton: DoneCheckButton!
    
    var parentVC : SlidingStackVC!
    let savedMedications = SavedMedicationDBS()
    
    var item: SavedMedicationDBT!
    {
        didSet {
            nameLabel.text = item.MedicationName
            amountLabel.text = "\(item.MedicationAmount) \(item.MedicationUOM)"
            doneCheckButton.IsDone = savedMedications.wasTaken(item: item)
            doneCheckButton.isUserInteractionEnabled = savedMedications.isTrackedToday(item: item)
            if(!doneCheckButton.isUserInteractionEnabled){
                backgroundColor = UIColor.lightGray
                backgroundColor?.withAlphaComponent(0.5)
            }
            else {
                backgroundColor = UIColor.clear
                backgroundColor?.withAlphaComponent(1.0)
            }
        }
    }
    
    override func customSetup() {
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        doneCheckButton.toggle()
        if(doneCheckButton.IsDone){
            SavedMedicationDBS().addTakenMedication(item: item)
        }
        else {
            SavedMedicationDBS().removeTakenMedication(item: item)
        }
        parentVC.reload()
    }
    
}

