//
//  Routine3PartCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/2/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class Routine3PartCell : UITableViewCell {
    
    @IBOutlet weak var labelLeft: UILabel!
    @IBOutlet weak var labelCenter: UILabel!
    @IBOutlet weak var labelRight: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization Code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //configure the view for the selected state
    }
    
}
