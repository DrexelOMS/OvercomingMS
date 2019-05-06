//
//  DoneCheckButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class DoneCheckButton: UIButton {
    
    var IsDone = false {
        didSet {
            setDone(done: IsDone)
        }
    }
    
    func toggle() {
        IsDone = !IsDone
    }
    
    private func setDone(done: Bool){
        if done {
            setImage(UIImage(named: "MedOn"), for: .normal)
        }
        else {
            setImage(UIImage(named: "MedOff"), for: .normal)
        }
    }
    
}
