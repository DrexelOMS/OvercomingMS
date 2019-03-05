//
//  NoteReviewSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class NoteReviewSVC: SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "NoteReviewSVC"
        }
    }
    
    @IBOutlet weak var deleteCircleButton: DeleteCircleButton!
    @IBOutlet weak var backConfirmButton: BackConfirmButtonsSVC!
    
    override func customSetup() {
        
    }
    
    override func initialize(parentVC: SwipeDownCloseViewController) {
        super.initialize(parentVC: parentVC)
        
        deleteCircleButton.colorTheme = parentVC.theme
        backConfirmButton.leftButtonAction = backPressed
    }
    
    override func reload() {
        
    }
    
    func backPressed() {
        parentVC.resetToDefaultView()
    }
    
}
