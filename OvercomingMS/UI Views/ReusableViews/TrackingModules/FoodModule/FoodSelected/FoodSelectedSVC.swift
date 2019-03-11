//
//  FoodSelectedApprovedSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography
import PTPopupWebView

class FoodSelectedSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "FoodSelectedSVC"
        }
    }
    var food: Food? = nil
    
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var approveDisaproveView: UIView!
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    convenience init(food:Food, unknown: Bool) {
        self.init()
        
        self.food = food
        if (unknown) {
            constrainView(view: FoodUnknownSVC())
        }
        else {
            constrainView(view: FoodApprovedSVC())
        }

        setLabel(name: food.Name, description: food.Brand)
    }
    
    convenience init(food: Food, ingredients: [String], types: [String]){
        self.init()
        
        self.food = food
        //initialize
        if(ingredients == [""] && types == [""]){
            constrainView(view: FoodUnknownSVC())
        }
        else{
            print(ingredients)
            print(types)
            let allBadStuff = ingredients + types
            constrainView(view: FoodRejectedSVC(_badLabels: allBadStuff))
        }
        
        setLabel(name: food.Name, description: food.Brand)
    }
    private func constrainView(view: UIView){
        
        approveDisaproveView.addSubview(view)
        
        constrain(view, approveDisaproveView) { (view, superview) in
            view.top == superview.top
            view.right == superview.right
            view.bottom == superview.bottom
            view.left == superview.left
        }
        
    }
    
    private func setLabel(name: String, description: String) {
        foodNameLabel.text = name
        foodDescriptionLabel.text = description
    }
    
    @IBAction func learnMoreButtonPressed(_ sender: Any) {
        
        let popupvc = PTPopupWebViewController()
        if let id = food?.Id {
            popupvc.popupView.URL(string: "https://world.openfoodfacts.org/product/" + id )
        }
        else {
            popupvc.popupView.URL(string: "https://world.openfoodfacts.org")
        }
        popupvc.show()

    }
    
    override func customSetup() {
        backButton.backButtonAction = backButtonPressed
    }
    
    override func updateColors() {
        backButton.colorTheme = parentVC.theme
    }
    
    func backButtonPressed() {
        parentVC.popSubView()
    }
    
}
