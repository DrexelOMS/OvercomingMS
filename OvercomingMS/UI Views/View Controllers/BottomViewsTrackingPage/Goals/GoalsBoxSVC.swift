//
//  PillBoxSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/12/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class GoalsBoxSVC : CustomView {
    
    override var nibName: String {
        get {
            return "GoalsBoxSVC"
        }
    }
    
    @IBInspectable var title : String {
        get {
            return titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }

    @IBInspectable var goalDescription : String {
        get {
            return descriptionLabel.text ?? ""
        }
        set {
            descriptionLabel.text = newValue
        }
    }
    
    @IBInspectable var colorTheme: UIColor = UIColor.gray {
        didSet {
            circleView.backgroundColor = colorTheme
        }
    }
    
    @IBOutlet weak var circleView: OMSRoundedBox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var roundedBoxView: RoundedBoxShadowsTemplate!
    
    override func customSetup() {
        
    }
}
