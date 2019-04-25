//
//  NoteCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var noteSVC: NoteSVC!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            noteSVC.roundBox.backgroundColor = noteSVC.theme.withAlphaComponent(0.6)
        } else {
            noteSVC.roundBox.backgroundColor = noteSVC.theme
        }
    }
    
}
