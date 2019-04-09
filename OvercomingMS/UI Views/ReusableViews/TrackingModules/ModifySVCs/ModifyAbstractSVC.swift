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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topPaddingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topLabelViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textInputStackBottom: NSLayoutConstraint!
    @IBOutlet weak var textInputStackView: UIStackView!
    @IBOutlet weak var backConfirmButtons: BackConfirmButtonsSVC!
    var originalBottomConstraint: CGFloat!
    var originalTopLabelContraint: CGFloat!
    var originalTopPaddingContraint: CGFloat!
    
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        originalBottomConstraint = textInputStackBottom.constant
        originalTopLabelContraint = topLabelViewHeight.constant
        originalTopPaddingContraint = topPaddingConstraint.constant
        
        for view in textInputStackView.arrangedSubviews {
            if let tfiView = view as? TFIAbstract {
                tfiView.parentVC = parentVC
                tfiView.tfiDelegate = self
            }
        }
    }
    
    override func updateColors() {
        backConfirmButtons.colorTheme = parentVC.theme
    }
    
    func BackPressed() {
        parentVC.popSubView()
    }
    
    func ConfirmPressed() {
        fatalError("Override Confirm Pressed")
    }
    
    private func hideOtherStackViews(_ tfi: TFIAbstract) {
        for view in self.textInputStackView.arrangedSubviews {
            if view != tfi {
                view.isHidden = true
            }
        }
    }
    
    private func showOtherStackViews(_ tfi: TFIAbstract) {
        for view in self.textInputStackView.arrangedSubviews {
            if view != tfi {
                view.isHidden = false
            }
        }
    }
    
    func OnTFIOpened(tfi: TFIAbstract, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions, keyboardHeight: CGFloat) {

        self.topPaddingConstraint.constant = 0
        self.topLabelViewHeight.constant = 0
        self.textInputStackBottom.constant = keyboardHeight - self.backConfirmButtons.bounds.height
        self.hideOtherStackViews(tfi)
        self.layoutIfNeeded()
        
    }
    
    func OnTFIClosed(tfi: TFIAbstract, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions, keyboardHeight: CGFloat) {
        
        self.topPaddingConstraint.constant = originalTopPaddingContraint
        self.topLabelViewHeight.constant = originalTopLabelContraint
        self.textInputStackBottom.constant = originalBottomConstraint
        self.showOtherStackViews(tfi)
        self.layoutIfNeeded()
        
    }
    
}
