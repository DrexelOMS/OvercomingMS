//
//  SlidingSubView.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SlidingAbstractSVC : CustomView {
    
    var parentVC: SlidingStackVC!{
        didSet {
            colorTheme = parentVC.theme
        }
    }
    var colorTheme : UIColor = UIColor.blue {
        didSet {
            updateColors()
        }
    }
    
    func onDismiss(function: @escaping ()->Void){
        parentVC.onDismiss = function
    }
    
    
    //MUST BE CALLED BY THE VC THAT USES THIS OBJECT
    func initialize(parentVC: SlidingStackVC){
        self.parentVC = parentVC
    }
    
    //SHOULD BE OVERRIDEN TO IMPLEMENT ANY RELOAD DATA METHODS
    func reload(){
        
    }
    
    //SHOLD BE OVERRIDEN TO IMPLEMENT ANY COLOR THEME UPDATES
    func updateColors() {

    }

    
}
