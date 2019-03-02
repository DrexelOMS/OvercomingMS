//
//  ReusableTest.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/26/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

//--Usage
//just inherit this class and override nibName and customSetup

@IBDesignable
class CustomView: UIView {
    
    var nibName: String {fatalError("nibName not overriden")}//{ return "TrackingProgressBar" }
    var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        guard let view = loadViewFromNib() else { return }
        
        view.frame = self.bounds

        self.addSubview(view)
        contentView = view
        
        //Custom View Modifications
        customSetup()
    }
    
    func customSetup(){
        fatalError("customSetup not overriden")
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    //MARk: Constraint Interfaces
    
    func anchorToView(superView: UIView){
        constrain(self, superView) { view, superView in
            view.top == superView.top
            view.right == superView.right
            view.bottom == superView.bottom
            view.left == superView.left
        }
    }
    
}
