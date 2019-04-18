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
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
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
    
    @IBOutlet weak var line: UIView!
    @IBInspectable var showLine: Bool = true {
        didSet {
            line.isHidden = !showLine
        }
    }
    
    override func customSetup() {
        
    }
}
