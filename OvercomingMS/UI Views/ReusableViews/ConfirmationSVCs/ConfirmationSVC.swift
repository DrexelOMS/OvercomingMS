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
    
    var methodToRunOnConfirm : (() -> ())?
    
    var resetToDefault: Bool = false
    
    override func customSetup() {
        let backConfirm = BackConfirmButtonSVC()
        bottomButtonView.addSubview(backConfirm)
        backConfirm.anchorToView(superView: bottomButtonView)
        
        topDescription.text = "test1"
        bottomDescription.text = "test2"
        
        backConfirm.leftButtonAction = backButtonPressed
        backConfirm.rightButtonAction = confirmButtonPressed
        
    }
    
    override func updateColors() {
        
    }
    
    func backButtonPressed() {
        parentVC.popSubView()
    }
    
    func confirmButtonPressed() {
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
    
}
