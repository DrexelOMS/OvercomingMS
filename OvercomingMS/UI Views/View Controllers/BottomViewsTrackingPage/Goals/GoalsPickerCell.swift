//
//  testCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/16/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class GoalsPickerCell : UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func setImage(_ image: UIImage) {
        for subUIView in self.subviews as [UIView] {
            subUIView.removeFromSuperview()
        }
        
        let imageView = UIImageView(image: image)
        self.addSubview(imageView)
        
        constrain(imageView, self) { (view, superView) in
            view.top == superView.top
            view.bottom == superView.bottom
            view.centerX == superView.centerX
            view.height == view.width
        }
    }
    
    func setLabelText(_ text: String) {
        let kerning = label.kerning
        label.text = text;
        label.kerning = kerning
    }
}

