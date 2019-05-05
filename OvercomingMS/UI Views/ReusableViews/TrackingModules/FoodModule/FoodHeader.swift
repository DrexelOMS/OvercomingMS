//
//  foodHeader.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 5/3/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class FoodHeader: CustomView {
    
    override var nibName: String {
        get {
            return "FoodHeader"
        }
    }
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func customSetup() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var compBarThickness = moduleProgressButtonHeight! * 2 / 9
        if compBarThickness > 16 {
            compBarThickness = 16
        }
        else if compBarThickness < 10 {
            compBarThickness = 10
        }
        
        let bigFontSize = compBarThickness + 10
        let smallFontSize = compBarThickness + 4
        
        leftLabel.font = UIFont(name: leftLabel.font.fontName, size: CGFloat(bigFontSize))
        rightLabel.font = UIFont(name: rightLabel.font.fontName, size: CGFloat(smallFontSize))
    }
    
}
