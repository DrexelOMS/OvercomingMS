//
//  CircleButtonSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/31/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class CircleButtonSVC: CustomView {
    
    override var nibName: String {
        get {
            return "CircleButtonSVC"
        }
    }
    
    var delegate : ButtonPressedDelegate?
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var buttonAction: (() -> ())?
    
    var colorTheme : UIColor = UIColor.black {
        didSet {
            label.textColor = colorTheme
            button.setTitleColor(colorTheme, for: .normal)
        }
    }
    
    override func customSetup() {
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.OnButtonPress(sender: sender)
    }
}
