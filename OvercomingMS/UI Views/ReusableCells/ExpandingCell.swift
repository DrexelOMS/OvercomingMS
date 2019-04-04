//
//  ExpandingCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/2/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class ExpandingCell : UITableViewCell {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var bottomHeight: NSLayoutConstraint!
    
    var middleStackView: UIStackView!
    
    
    //MUST call clear before doing anything to this cell
    func clear() {
        
        bottomView.isHidden = false
        
        if let view = middleStackView {
            view.removeFromSuperview()
        }
        middleStackView = UIStackView()
        middleView.addSubview(middleStackView)
        
        constrain(middleStackView, middleView) { (view, _superView) in
            view.top == _superView.top
            view.right == _superView.right
            view.bottom == _superView.bottom
            view.left == _superView.left
        }
        
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.axis = NSLayoutConstraint.Axis.vertical
        middleStackView.distribution = UIStackView.Distribution.equalSpacing
    }
    
    func hideBottomView() {
        bottomView.isHidden = true
        bottomHeight.constant = 0
    }
    
    func addToMiddle(view: UIView) {
        middleStackView.addArrangedSubview(view)
    }
}
