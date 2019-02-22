//
//  FoodSelectedApprovedSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class FoodSelectedSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "FoodSelectedSVC"
        }
    }
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    //change stuff to what you want to pass in when you instantiate the class with FoodSelected
    convenience init(stuff: String){
        self.init()
        
        //initialize
    }
    
    override func customSetup() {
        backButton.backButtonAction = backButtonPressed
    }
    
    func backButtonPressed() {
        parentVC.popSubView()
    }
    
}
