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
    }
    
}

