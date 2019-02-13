//
//  AddCircleButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/2/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SearchCircleButton : CircleButtonSVC {
    
    override func customSetup() {
        //button.setTitle("+", for: .normal)
        buttonImage = UIImage(named: "Search")
        label.text = "Search"
    }
}
