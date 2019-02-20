//
//  ModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class ModifyAbstractSVC : SlidingAbstractSVC, TFIDelegate  {
    
    override var nibName: String {
        get {
            return "ModifyAbstractSVC"
        }
    }

    @IBOutlet weak var topLabelViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textInputStackBottom: NSLayoutConstraint!
    @IBOutlet weak var textInputStackView: UIStackView!
    @IBOutlet weak var backConfirmButtons: BackConfirmButtonsSVC!
    
    override func updateColors() {
        print("remember to update colors")
    }
    
    func BackPressed() {
        parentVC.popSubView()
    }
    
    func ConfirmPressed() {
        fatalError("Override Confirm Pressed")
    }
    
    func OnTFIOpened(tfi: TFIAbstract, inputHeight: CGFloat) {
        topLabelViewHeight.constant = 0
        textInputStackBottom.constant += inputHeight - backConfirmButtons.bounds.height
        layoutIfNeeded()

        for  view in textInputStackView.arrangedSubviews {
            if view != tfi {
                view.isHidden = true
            }
        }
        
    }
    
    func OnTFIClosed(tfi: TFIAbstract, inputHeight: CGFloat) {
        topLabelViewHeight.constant = 100
        textInputStackBottom.constant -= inputHeight - backConfirmButtons.bounds.height
        layoutIfNeeded()
        
        for  view in textInputStackView.arrangedSubviews {
            if view != tfi {
                view.isHidden = false
            }
        }
        
    }
    
}
