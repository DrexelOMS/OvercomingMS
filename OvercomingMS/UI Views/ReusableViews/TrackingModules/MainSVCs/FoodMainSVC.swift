//
//  ExerciseMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class FoodMainSVC: SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "FoodMainSVC"
        }
    }
    
    let button1 = SearchCircleButton()
    let button2 = RecipesCircleButton()
    let button3 = ScanCircleButton()
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
    override func customSetup() {
        
    }
    
    //must be called by 
    override func initialize(parentVC: TrackingModuleAbstractVC) {
        super.initialize(parentVC: parentVC)
        
        button1.buttonAction = searchButtonPressed
        button2.buttonAction = recipesButtonPressed
        button3.buttonAction = scanButtonPressed
        
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.addArrangedSubview(button2)
        buttonStackView.addArrangedSubview(button3)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func searchButtonPressed() {
        //parentVC.pushSubView(newSubView: ExerciseAddSVC())
        print("Pressed Search")
    }
    
    func recipesButtonPressed() {
        //parentVC.pushSubView(newSubView: ExerciseStopwatchSVC())
        print("Pressed Recipes")
    }
    
    func scanButtonPressed() {
        //parentVC.pushSubView(newSubView: ExerciseStopwatchSVC())
        print("Pressed Scan")
    }
    
    override func updateColors() {
        button1.colorTheme = parentVC.theme
        button2.colorTheme = parentVC.theme
        button3.colorTheme = parentVC.theme
    }

}
