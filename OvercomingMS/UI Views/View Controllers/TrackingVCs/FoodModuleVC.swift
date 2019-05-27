//
//  FoodModuleVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 5/3/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class FoodModuleVC: SlidingStackVC {
    
    var foodContainer: FoodHeader!
    var bigFontSize = 24
    var smallFontSize = 16
    
    override func addViewsBeforeMain() {
        let topView = UIView()
        contentStackView.addArrangedSubview(topView)
        
        var height = 45
        if let tempHeight = moduleProgressButtonHeight {
            if tempHeight > 65 {
                height = 65
            }
            else if tempHeight < 45 {
                height = 45
            }
        }
        
        constrain(topView) { (view) in
            view.height == CGFloat(height)
        }
        
        foodContainer = FoodHeader()
        
        var rate = 1 - ((65 - height)) / 20
        rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
        
        bigFontSize = 20 + (8) * rate
        smallFontSize = 14  + (6) * rate
        
        topView.addSubview(foodContainer)
        
        constrain(foodContainer, topView) { (view, superView) in
            view.top == superView.top
            view.right == superView.right - 20
            view.left == superView.left + 20
        }
        
        let lineSeparatorView = UIView()
        lineSeparatorView.backgroundColor = UIColor.lightGray
        
        topView.addSubview(lineSeparatorView)
        
        constrain(lineSeparatorView, topView) { (view, superView) in
            view.height == 1
            view.right == superView.right - 20
            view.bottom == superView.bottom
            view.left == superView.left + 20
        }
        constrain(lineSeparatorView, foodContainer) { (view, aboveView) in
            view.top == aboveView.bottom + 10
        }
    }
    
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.async {
            self.foodContainer.leftLabel.font = UIFont(name: self.foodContainer.leftLabel!.font.fontName, size: CGFloat(self.bigFontSize))
            self.foodContainer.rightLabel.font = UIFont(name: self.foodContainer.rightLabel!.font.fontName, size: CGFloat(self.smallFontSize))
        }
    }
}
