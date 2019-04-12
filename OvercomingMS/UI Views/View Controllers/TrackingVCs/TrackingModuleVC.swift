//
//  TrackingModuleAbstractVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class TrackingModuleVC: SlidingStackVC {
    
    let progressBar = TrackingProgressBar()
    
    private var trackingDBS: TrackingModulesDBS!
    private var mainViewToSet: SlidingAbstractSVC!
    
    convenience init(title: String, trackingDBS: TrackingModulesDBS, mainViewToSet: SlidingAbstractSVC) {
        self.init()
        
        progressBar.setTitle(title: title)
        self.trackingDBS = trackingDBS
        self.mainViewToSet = mainViewToSet
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeviewStack(defaultView: mainViewToSet)
    }
    
    override func addViewsBeforeMain() {
        let progressView = UIView()
        contentStackView.addArrangedSubview(progressView)
        constrain(progressView) { (view) in
            view.height == 60.0
        }
        
        progressView.addSubview(progressBar)
        
        constrain(progressBar, progressView) { (view, superView) in
            view.top == superView.top
            view.right == superView.right - 20
            view.left == superView.left + 20
        }
        
        progressBar.colorTheme = theme
        progressBar.toggleCheckMarkVisibility(isHidden: true)
        
        let lineSeparatorView = UIView()
        lineSeparatorView.backgroundColor = UIColor.lightGray
        
        progressView.addSubview(lineSeparatorView)
        
        constrain(lineSeparatorView, progressView) { (view, superView) in
            view.height == 1
            view.right == superView.right - 20
            view.bottom == superView.bottom
            view.left == superView.left + 20
        }
        constrain(lineSeparatorView, progressBar) { (view, aboveView) in
            view.top == aboveView.bottom + 20
        }
    }
    
    override func reload() {
        progressBar.update(trackingDBS: trackingDBS)
    }
    
}
