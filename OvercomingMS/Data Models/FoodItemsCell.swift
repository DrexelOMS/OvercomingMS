//
//  FoodItemsCell.swift
//  OvercomingMS
//
//  Created by Vince on 1/12/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class FoodItemsCell : UITableViewCell {
    
    @IBOutlet weak var FoodItemNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization Code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //configure the view for the selected state
    }
}
