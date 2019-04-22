//
//  SymptomsListCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/6/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class SymptomsListCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var middleView: UIView!
    
    var middleStackView: UIStackView!
    
    //MUST call clear before doing anything to this cell
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
        middleStackView.spacing = 20
    }
    
    func addToMiddle(view: UIView) {
        middleStackView.addArrangedSubview(view)
    }
}
