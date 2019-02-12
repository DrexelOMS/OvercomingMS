//
//  PullBarSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/12/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class PullBarSVC : CustomView {
    
    override var nibName: String {
        get {
            return "PullBarSVC"
        }
    }
    
    var colorTheme: UIColor? {
        didSet {
            pullDownView.backgroundColor = colorTheme
        }
    }
    
    @IBOutlet weak var pullDownView: UIView!
    
    override func customSetup() {
        
    }
    
}
