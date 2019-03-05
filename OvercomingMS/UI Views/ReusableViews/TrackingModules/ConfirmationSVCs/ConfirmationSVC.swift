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
    
    private var methodToRunOnConfirm : (() -> ())?
    
    private var resetToDefault: Bool = false
    
    convenience init(methodToRunOnConfirm: @escaping (() ->()), resetToDefault: Bool) {
        self.init()
        
        self.methodToRunOnConfirm = methodToRunOnConfirm
        self.resetToDefault = resetToDefault
    }
    
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
    
}
