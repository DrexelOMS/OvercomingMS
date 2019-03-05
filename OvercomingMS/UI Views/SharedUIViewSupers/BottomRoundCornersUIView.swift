//
//  RoundCornersUIView.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

@IBDesignable
class BottomRoundCornersUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        
//        if #available(iOS 11.0, *){
//            self.clipsToBounds = false
//            self.layer.cornerRadius = bounds.height / 4
//            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        }else{
//            let rectShape = CAShapeLayer()
//            rectShape.bounds = self.frame
//            rectShape.position = self.center
//            rectShape.path = UIBezierPath(roundedRect: self.bounds,    byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
//            self.layer.mask = rectShape
//        }
//        self.layer.addShadow()
        
    }
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 15.0
    private var fillColor: UIColor = .white // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height - 4), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            //shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            shadowLayer.shadowRadius = 1.0
            shadowLayer.shadowOpacity = 0.3
            
            shadowLayer.masksToBounds = false
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }

}
