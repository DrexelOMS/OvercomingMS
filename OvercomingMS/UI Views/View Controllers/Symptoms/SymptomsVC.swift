//
//  SymptomsVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class SymptomsVC : SlidingStackVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initializeviewStack(defaultView: SymptomsMainSVC())
    }
    
    override func addViewsBeforeMain() {
        let image = UIImage(named: "Symptons")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        constrain(imageView) { (view) in
            view.height == 20
        }
        
        let view = UIView()
        view.addSubview(imageView)
        constrain(view) { (view) in
            view.height == 30
        }
        
        constrain(imageView, view) { (view, superView) in
            view.centerY == superView.centerY
            view.centerX == superView.centerX
        }
        contentStackView.addArrangedSubview(view)
    }
    
}
