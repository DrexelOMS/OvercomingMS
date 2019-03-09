//
//  TitleTimeOverTextCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TitleTimeOverTextCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization Code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //configure the view for the selected state
    }
    
}
