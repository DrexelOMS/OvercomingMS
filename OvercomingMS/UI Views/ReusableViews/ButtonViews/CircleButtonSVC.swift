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
    
    @IBInspectable var buttonImage: UIImage? {
        didSet {
            button.setImage(buttonImage, for: .normal)
        }
    }
    @IBInspectable var labelName: String = "Label" {
        didSet {
            label.text = labelName
        }
    }
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var buttonAction : (() -> ())?
    
    var colorTheme : UIColor = UIColor.black {
        didSet {
            label.textColor = colorTheme
            button.setTitleColor(colorTheme, for: .normal)
        }
    }
    
    override func customSetup() {
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let buttonAction = buttonAction else {
            fatalError("ButtonAction not set")
        }
        buttonAction()
    }
}
