//
//  MainAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MainAbstractSVC: SlidingAbstractSVC {
    
    var defaultCellName : String = "Routine3PartCell"
    
    @IBOutlet weak var totalsCountLabel : UILabel!
    @IBOutlet weak var totalsTextLabel: UILabel!
    //@IBOutlet var internetPopUpButton : UIButton!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var buttonStackView : UIStackView!

}
