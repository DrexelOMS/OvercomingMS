//
//  MedicationCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MedicationCell : UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var doneCheckButton: DoneCheckButton!
    
    var parentVC : SwipeDownCloseViewController!
    let savedMedications = SavedMedicationDBS()
    
    var item: SavedMedicationDBT!
    {
        didSet {
            timeLabel.text = OMSDateAccessor.getDateTime(date: item.TimeOfDay)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization Code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //configure the view for the selected state
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

