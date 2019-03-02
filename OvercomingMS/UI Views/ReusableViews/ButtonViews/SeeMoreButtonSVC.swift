//
//  SeeMoreButtonSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SeeMoreButtonSVC : CustomView {
    
    override var nibName: String {
        get {
            return "SeeMoreButtonSVC"
        }
    }
    
    override func customSetup() {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(tapGestureRecognizer: )))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func buttonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        print("buttonTapped")
    }
    
}
