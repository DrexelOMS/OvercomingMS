//
//  ConfirmationSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ConfirmationSVC: SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "ConfirmationSVC"
        }
    }
    
    @IBOutlet weak var topDescription: UILabel!
    @IBOutlet weak var bottomDescription: UILabel!
    @IBOutlet weak var bottomButtonView: UIView!
    let backConfirm = BackConfirmButtonsSVC()
    
    var methodToRunOnConfirm : (() -> ())?
    var resetToDefault: Bool = false
    
    override func customSetup() {
        bottomButtonView.addSubview(backConfirm)
        backConfirm.anchorToView(superView: bottomButtonView)
        
        backConfirm.leftButtonAction = backButtonPressed
        backConfirm.rightButtonAction = confirmButtonPressed
        
    }
    
    override func updateColors() {
        backConfirm.colorTheme = parentVC.theme
    }
    
    private func backButtonPressed() {
        parentVC.popSubView()
    }
    
    private func confirmButtonPressed() {
        guard let methodToRun = methodToRunOnConfirm else {
            fatalError("ButtonAction not set")
        }
        
        methodToRun()
        
        if(resetToDefault)  {
            parentVC.resetToDefaultView()
        }
        else {
            parentVC.popSubView()
        }
    }
    
    override func didLayoutSubviews() {
        DispatchQueue.main.async {
            print(self.frame.height)
            let rate = 1 - ((712 - self.frame.height)) / (712 - 462)
            print(rate)
            let bigFontSize = 24  + (10) * rate
            let smallFontSize = 18  + (8) * rate
            self.topDescription.font = UIFont(name: self.topDescription!.font.fontName, size: bigFontSize)
            self.bottomDescription.font = UIFont(name: self.bottomDescription!.font.fontName, size: smallFontSize)
        }
    }
    
}
