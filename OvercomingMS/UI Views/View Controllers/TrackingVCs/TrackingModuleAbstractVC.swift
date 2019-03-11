//
//  TrackingModuleAbstractVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class TrackingModuleAbstractVC: SlidingStackVC {
    
    //MARK: Attributes
    
    var progressBar: TrackingProgressBar = TrackingModuleProgressBar()
    
    override func addViewsBeforeMain() {
        let progressView = UIView()
        contentStackView.addArrangedSubview(progressView)
        constrain(progressView) { (view) in
            view.height == 60.0
        }
        
        progressView.addSubview(progressBar)
        
        constrain(progressBar, progressView) { (view, superView) in
            view.top == superView.top - 0
            view.right == superView.right - 20
            view.bottom == superView.bottom - 20
            view.left == superView.left + 20
        }
        
        progressBar.colorTheme = theme
    }
    
}
