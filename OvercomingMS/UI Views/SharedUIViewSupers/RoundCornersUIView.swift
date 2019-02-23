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
    
    @IBInspectable var hasShadow: Bool = true {
        didSet {
            if(hasShadow) {
                layer.addShadow()
            }
            else {
                layer.masksToBounds = true
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        layer.roundCorners(radius: bounds.height / 4)
        layer.addShadow()
    }

}

extension CALayer {
    
    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter{ $0.frame.equalTo(self.bounds) }
                .forEach{ $0.roundCorners(radius: self.cornerRadius) }
            self.contents = nil
            if let sublayer = sublayers?.first,
                sublayer.name == "subLayer" {
                
                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
            contentLayer.name = "subLayer"
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
        }
    }

    func addShadow() {
        self.shadowColor = UIColor.black.cgColor
        self.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.shadowRadius = 1.0
        self.shadowOpacity = 0.3
        self.masksToBounds = false
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }

}
