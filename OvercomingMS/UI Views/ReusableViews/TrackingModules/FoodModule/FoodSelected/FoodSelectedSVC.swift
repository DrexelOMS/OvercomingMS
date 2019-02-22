//
//  FoodSelectedApprovedSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class FoodSelectedSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "FoodSelectedSVC"
        }
    }
    
    @IBOutlet weak var approveDisaproveView: UIView!
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    //change stuff to what you want to pass in when you instantiate the class with FoodSelected
    convenience init(stuff: String){
        self.init()
        
        //initialize
        
        //let view = FoodApprovedSVC()
        let view = FoodRejectedSVC()
        
        approveDisaproveView.addSubview(view)
        
        constrain(view, approveDisaproveView) { (view, superview) in
            view.top == superview.top
            view.right == superview.right
            view.bottom == superview.bottom
            view.left == superview.left
        }
    }
    
    override func customSetup() {
        backButton.backButtonAction = backButtonPressed
    }
    
    func backButtonPressed() {
        parentVC.popSubView()
    }
    
}
