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
        
        let foodContainer = FoodHeader()
        
//        var compBarThickness = height * 2 / 9
//        if compBarThickness > 16 {
//            compBarThickness = 16
//        }
//        else if compBarThickness < 10 {
//            compBarThickness = 10
//        }
//        
//        let bigFontSize = compBarThickness + 7
//        let smallFontSize = compBarThickness + 3
//        
//        foodContainer.leftLabel.font = UIFont(name: foodContainer.leftLabel.font.fontName, size: CGFloat(bigFontSize))
//        foodContainer.rightLabel.font = UIFont(name: foodContainer.rightLabel.font.fontName, size: CGFloat(smallFontSize))
        
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

}
