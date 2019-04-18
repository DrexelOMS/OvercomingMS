//
//  testCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/16/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class GoalsPickerCell : UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func setLabelText(_ text: String) {
        let kerning = label.kerning
        label.text = text;
        label.kerning = kerning
    }
}

