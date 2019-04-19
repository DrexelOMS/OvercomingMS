//
//  SettingsBoxSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/12/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SettingsBoxSVC: CustomView {
    
    override var nibName: String {
        get {
            return "SettingsBoxSVC"
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
    
    var buttonAction : (() -> ())?
    
    @IBOutlet weak var roundedView: RoundedBoxShadowsTemplate!
    @IBOutlet weak var titleLabel: UILabel!

    override func customSetup() {
        roundedView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(tapGestureRecognizer: )))
        roundedView.addGestureRecognizer(tapGesture)
    }
    
    @objc func buttonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let buttonAction = buttonAction else {
            fatalError("ButtonAction not set")
        }
        buttonAction()
    }
}
