//
//  TitleDescriptionHeader.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

@IBDesignable
class TitleDescriptionHeaderSVC : SlidingAbstractSVC {
    override var nibName: String {
        get {
            return "TitleDescriptionHeaderSVC"
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBInspectable var titleText: String {
        get {
            return titleLabel.text!
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    @IBInspectable var descriptionText: String {
        get {
            return descriptionLabel.text!
        }
        set {
            descriptionLabel.text = newValue
        }
    }
    
    override func customSetup() {
        
    }
}
