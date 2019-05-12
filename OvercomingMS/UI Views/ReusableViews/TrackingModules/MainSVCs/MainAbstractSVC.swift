//
//  MainAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MainAbstractSVC: SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "MainAbstractSVC"
        }
    }
    
    var defaultCellName : String = "Routine3PartCell"
    
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var totalsView: UIView!
    @IBOutlet weak var totalsCountLabel : UILabel!
    @IBOutlet weak var totalsTextLabel: UILabel!
    @IBOutlet weak var internetPopupButton: SeeMoreButtonSVC!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var buttonStackView : UIStackView!
    
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        internetPopupButton.parentVC = parentVC
    }

    override func didLayoutSubviews(){
        // minimum font size 80, max font size 120
        // minimum height = 72, max height = 150
        var rate = 1 - ((150 - totalsCountLabel.frame.height)) / 78
        rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
        
        let bigFontSize = 80  + (30) * rate
        let smallFontSize = 28  + (12) * rate
        
        DispatchQueue.main.async {
            self.totalsCountLabel.font = UIFont(name: self.totalsCountLabel!.font.fontName, size: bigFontSize)
            self.totalsTextLabel.font = UIFont(name: self.totalsTextLabel!.font.fontName, size: smallFontSize)
        }
    }
        
}
