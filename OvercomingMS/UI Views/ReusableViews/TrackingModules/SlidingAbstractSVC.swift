//
//  SlidingSubView.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SlidingAbstractSVC : CustomView {
    
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
    
    //MUST BE CALLED BY THE VC THAT USES THIS OBJECT
    func initialize(parentVC: TrackingModuleAbstractVC){
        self.parentVC = parentVC
    }
    
    //SHOULD BE OVERRIDEN TO IMPLEMENT ANY RELOAD DATA METHODS
    func reload(){
        
    }
    
    //SHOLD BE OVERRIDEN TO IMPLEMENT ANY COLOR THEME UPDATES
    func updateColors() {

    }

}
