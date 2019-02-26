//
//  ToggleLabeledCircleButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ToggleLabelCircleButton: RoundButton {
    
    var IsDone = false {
        didSet {
            setDone(done: IsDone)
        }
    }
    
    override func setup() {
        super.setup()
        IsDone = false
    }
    
    func toggle() {
        IsDone = !IsDone
    }
    
    private func setDone(done: Bool){
        if done {
            backgroundColor = UIColor.black
            setTitleColor(UIColor.white, for: .normal)
        }
        else {
            backgroundColor = UIColor.white
            setTitleColor(UIColor.black, for: .normal)
        }
    }
    
}
