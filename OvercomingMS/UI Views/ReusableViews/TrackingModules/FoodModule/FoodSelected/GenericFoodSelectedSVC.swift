//
//  GenericFoodSelectedSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/19/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class GenericFoodSelectedSVC : CustomView {
    
    override var nibName: String {
        get {
            return "GenericFoodSelectedSVC"
        }
    }
    
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    
    
    override func customSetup() {
        
    }
    
    override func layoutSubviews() {
        DispatchQueue.main.async {
            var rate = 1 - ((896 -  UIScreen.main.bounds.height)) / 328
            rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
            
            let bigFontSize = 18 + (6) * rate
            let fontSize = 14 + (4) * rate
            
            self.checkLabel.font = UIFont(name: self.checkLabel.font.fontName, size: fontSize)
            let font = UIFont(name: self.label1.font.fontName, size: bigFontSize)
            
            self.label1.font = font
            self.label2.font = font
            self.label3.font = font
            self.label4.font = font
            self.label5.font = font
            self.label6.font = font
            self.label7.font = font
            self.label8.font = font
            
        }
    }
}
