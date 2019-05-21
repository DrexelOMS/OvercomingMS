//
//  FoodApprovedSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//
import UIKit

class FoodApprovedSVC: CustomView {
    
    override var nibName: String {
        get {
            return "FoodApprovedSVC"
        }
    }
    
    override func customSetup() {
        
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func layoutSubviews() {
        DispatchQueue.main.async {
            var rate = 1 - ((896 -  UIScreen.main.bounds.height)) / 328
            rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
            
            let fontSize = 20 + (8) * rate
            
            self.label.font = UIFont(name: self.label.font.fontName, size: fontSize)
        }
    }
    
}
