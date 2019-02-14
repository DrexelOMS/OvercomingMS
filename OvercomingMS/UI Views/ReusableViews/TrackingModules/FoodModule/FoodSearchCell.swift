//
//  FoodSearchCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class FoodSearchCell : UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet private weak var recommendedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization Code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //configure the view for the selected state
    }
    
    func setRecommendedStatus(isGood: Bool) {
        if isGood {
            recommendedLabel.text = "G"
        }
        else {
            recommendedLabel.text = "B"
        }
        
    }
    
}
