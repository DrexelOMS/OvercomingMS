//
//  SlidingSubView.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SlidingAbstractSVC : CustomView {
    
    //MUST BE CALLED BY THE VC THAT USES THIS OBJECT
    func initialization(parentVC: TrackingModuleAbstractVC){
        self.parentVC = parentVC
    }
    
    var parentVC: TrackingModuleAbstractVC!{
        didSet {
            colorTheme = parentVC.theme
        }
    }
    var colorTheme : UIColor = UIColor.blue {
        didSet {
            updateColors()
        }
    }
    
    func updateColors() {
        fatalError("Astract Method")
    }

}

extension SlidingAbstractSVC {
    
    var exerciseVC : ExerciseModuleVC! {
        get {
            return parentVC as? ExerciseModuleVC
        }
    }
    
}
