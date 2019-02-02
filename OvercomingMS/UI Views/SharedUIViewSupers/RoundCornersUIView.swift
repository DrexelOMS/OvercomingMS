//
//  RoundCornersUIView.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

@IBDesignable
class RoundCornersUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        layer.cornerRadius = bounds.height / 4
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
