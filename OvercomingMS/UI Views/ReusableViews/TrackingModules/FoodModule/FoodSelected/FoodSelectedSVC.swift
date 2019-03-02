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
    
    convenience init(unknown: Bool) {
        self.init()
        
        var view = UIView()
        if (unknown) {
            view = FoodUnknownSVC()
        }
        else {
            view = FoodApprovedSVC()
        }
        
        approveDisaproveView.addSubview(view)
        
        constrain(view, approveDisaproveView) { (view, superview) in
            view.top == superview.top
            view.right == superview.right
            view.bottom == superview.bottom
            view.left == superview.left
        }
    }
    
    //change stuff to what you want to pass in when you instantiate the class with FoodSelected
    convenience init(ingredients: [String], types: [String]){
        self.init()

        var view = UIView()
        
        //initialize
        if(ingredients == [""]){
            view = FoodApprovedSVC()
        }
        else{
            print(ingredients)
            print(types)
            let allBadStuff = ingredients + types
            view = FoodRejectedSVC(_badLabels: allBadStuff)

        }
        
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
