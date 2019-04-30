//
//  FoodSelectedApprovedSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography
import TOWebViewController

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
        constrainView(view: GenericFoodSelectedSVC())
        setLabel(name: "Unknown Item", description: "We couldn't find information on that item")
    }
    
    convenience init(food: Food, ingredients: [String], types: [String]){
        self.init()
        
        self.food = food
        //initialize
        if(ingredients == [""] && types == [""]){
            constrainView(view: GenericFoodSelectedSVC())
            setLabel(name: "Unknown Item", description: "We couldn't find information on that item")
        }
        else{
            let allBadStuff = ingredients + types
            constrainView(view: FoodRejectedSVC(_badLabels: allBadStuff))
            setLabel(name: food.Name, description: food.Brand)
        }
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
        
        var url = ""
        if let id = food?.Id {
            url = "https://world.openfoodfacts.org/product/" + id
        }
        else {
            url = "https://world.openfoodfacts.org"
        }
        
        let webViewController = TOWebViewController(urlString: url)
        let navigation = UINavigationController.init(rootViewController: webViewController)
        
        parentVC.present(navigation, animated: true, completion: nil)

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
