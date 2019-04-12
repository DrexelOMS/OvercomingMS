//
//  TopImageSlidingStackVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class TopImageSlidingStackVC : SlidingStackVC {
    let imageContainer = UIView()
    var topImage : UIImage!
    
    convenience init(topImage: UIImage, initialView: SlidingAbstractSVC) {
        self.init(initialView: initialView)
        
        self.topImage = topImage
    }
    
    override func addViewsBeforeMain() {
        let imageView = UIImageView(image: topImage)
        imageView.contentMode = .scaleAspectFit
        constrain(imageView) { (view) in
            view.height == 20
        }
        
        imageContainer.addSubview(imageView)
        constrain(imageContainer) { (view) in
            view.height == 40
        }
        
        constrain(imageView, imageContainer) { (view, superView) in
            view.centerY == superView.centerY
            view.centerX == superView.centerX
        }
        contentStackView.addArrangedSubview(imageContainer)
    }
    
    func toggleTopImage(isHidden: Bool){
        imageContainer.isHidden = isHidden
    }
    
}
