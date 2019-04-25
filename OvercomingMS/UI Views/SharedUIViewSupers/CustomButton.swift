//
//  CustomButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol ButtonDelegate: class {
    func isHighlighted(highlighted: Bool)
}

class CustomButton : UIButton {
    
    var aggregator: ButtonDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        aggregator?.isHighlighted(highlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        aggregator?.isHighlighted(highlighted: false)
    }
    
}
