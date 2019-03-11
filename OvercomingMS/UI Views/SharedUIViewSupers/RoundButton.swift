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
    
    func setup(){
        layer.cornerRadius = layer.bounds.size.width / 2
        layoutSubviews()
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.20
        
        //layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.5)
        //layer.borderWidth = 1
    }

}
