//
//  SelectedLabelsSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/18/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SelectedLabelsSVC : CustomView {
    
    override var nibName: String {
        get {
            return "SelectedLabelsSVC"
        }
    }
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    convenience init(mainLabel: String, subLabel: String) {
        self.init()
        
        self.mainLabel.text = mainLabel
        self.subLabel.text = subLabel
    }
    
    override func customSetup() {
        
    }
    
}
