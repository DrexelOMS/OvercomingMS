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
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var middleStackView: UIStackView!
    
    func clear() {
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
    
    func addToMiddle(view: UIView) {
        middleStackView.addArrangedSubview(view)
    }
}
