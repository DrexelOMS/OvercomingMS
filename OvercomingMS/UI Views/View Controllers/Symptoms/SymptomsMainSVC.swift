//
//  SymptomsMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SymptomsMainSVC: SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "SymptomsMainSVC"
        }
    }
    
    @IBOutlet weak var plusButtonView: UIView!
    
    override func customSetup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(plusButtonPressed(gesture: )))
        plusButtonView.addGestureRecognizer(tapGesture)
    }
    
    override func reload() {
        
    }
    
    @objc func plusButtonPressed(gesture: UITapGestureRecognizer) {
        parentVC.pushSubView(newSubView: NoteReviewSVC())
    }
    
}
