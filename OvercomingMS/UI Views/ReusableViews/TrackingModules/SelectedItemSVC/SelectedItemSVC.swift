//
//  SelectedItemSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SelectedItemSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "SelectedItemSVC"
        }
    }
    
    @IBOutlet weak var topSubLabel: UILabel!
    @IBOutlet weak var topMainLabel: UILabel!
    @IBOutlet weak var middleSubLabel: UILabel!
    @IBOutlet weak var middleMainLabel: UILabel!
    @IBOutlet weak var bottomSubLabel: UILabel!
    @IBOutlet weak var bottomMainLabel: UILabel!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
    override func customSetup() {
        //TODO: add the edit, repeat, and delete buttons
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        parentVC.popSubView()
    }
}
