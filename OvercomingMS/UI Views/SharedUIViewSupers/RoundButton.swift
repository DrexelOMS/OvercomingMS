//
//  RoundButton.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    private func setup(){
        layer.cornerRadius = layer.bounds.size.width / 2
        layoutSubviews()
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.3
        
        layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.5)
        layer.borderWidth = 1
    }

}
