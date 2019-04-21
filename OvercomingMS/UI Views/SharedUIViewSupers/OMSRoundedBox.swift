//
//  OMSRoundedBox.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/6/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

@IBDesignable
class OMSRoundedBox: UIView {
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//
//    override func prepareForInterfaceBuilder() {
//        setup()
//    }
    
    @IBInspectable var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    /// The radius of the view's rounded corners
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    /// The width of the border applied to the view
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// The color of the border applied to the views
    @IBInspectable public var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    /// The color of the shadow applied to the view
    @IBInspectable public var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    /// The offet of the shadow in the form (x, y)
    @IBInspectable public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// The blur of the shadown
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// The opacity of the shadow applied to the view
    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            layer.masksToBounds = false
        }
    }
    
    func toggleSelected(isSelected: Bool) {
        if isSelected {
            backgroundColor = UIColor.gray
        }
        else {
            backgroundColor = UIColor.white
        }
    }
    
}

class RoundedBoxTemplate: OMSRoundedBox {
    
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
        cornerRadius = 15
        maskToBounds = true
    }
    
}

class RoundedBoxShadowsTemplate: OMSRoundedBox {
    
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
        cornerRadius = 15
        shadowColor = UIColor.black
        shadowOffset = CGSize(width: 2, height: 2)
        shadowRadius = 3
        shadowOpacity = 0.18
    }
    
}
