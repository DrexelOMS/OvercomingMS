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
    
    @IBOutlet private weak var circleView: OMSRoundedBox!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var roundedBoxView: RoundedBoxShadowsTemplate!
    
    var buttonAction : (() -> ())?
    
    override func customSetup() {
        roundedBoxView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(tapGestureRecognizer: )))
        roundedBoxView.addGestureRecognizer(tapGesture)
    }
    
    @objc func buttonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let buttonAction = buttonAction else {
            fatalError("ButtonAction not set")
        }
        buttonAction()
    }
}
