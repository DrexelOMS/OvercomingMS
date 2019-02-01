//
//  MainAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MainAbstractSVC: SlidingAbstractSVC {
    
    @IBOutlet var mainLabel : UILabel!
    @IBOutlet var internetPopUpButton : UIButton!
    @IBOutlet var tableView : UITableView!
    @IBOutlet var addButton : UIButton!
    @IBOutlet var timerButton : UIButton!
//    @IBOutlet var addSVC : ModifyAbstractSVC!
//    @IBOutlet var editSVC : ModifyAbstractSVC!
//    @IBOutlet var mainLabel : ModifyAbstracSVC!
    
    override func customSetup() {

    }
    
    override func updateColors(){
        addButton.backgroundColor = colorTheme
        mainLabel.backgroundColor = colorTheme
    }

}
