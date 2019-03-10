//
//  ExerciseMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift
import BarcodeScanner
import PTPopupWebView

class FoodMainSVC: SlidingAbstractSVC, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    
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
    override func initialize(parentVC: SlidingStackVC) {
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
        parentVC.pushSubView(newSubView: FoodSearchSVC())
    }
    
    func recipesButtonPressed() {
        let popupvc = PTPopupWebViewController()
        popupvc.popupView.URL(string: "https://overcomingms.org/recovery-program/recipes/")
        popupvc.show()
    }
    
    func scanButtonPressed() {
        let barcodeScannerVC = BarcodeScannerViewController()
        barcodeScannerVC.codeDelegate = self
        barcodeScannerVC.errorDelegate = self
        barcodeScannerVC.dismissalDelegate = self
        
        parentVC.present(barcodeScannerVC, animated: true, completion: nil)
    }
    
    override func updateColors() {
        button1.colorTheme = parentVC.theme
        button2.colorTheme = parentVC.theme
        button3.colorTheme = parentVC.theme
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
        //actually initialize the food object. swift is dumb
        var foodinfo: Food = Food(id: "",name: "",categories: "",satfats: 0,ingredients: "",  brand: "")
        foodinfo.getFoodFromID(id: "3181232127608", parentVC: self.parentVC)
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        controller.dismiss(animated: true) {
            //actually initialize the food object. swift is dumb
            var foodinfo: Food = Food(id: "",name: "",categories: "",satfats: 0,ingredients: "", brand:"")
            foodinfo.getFoodFromID(id: code, parentVC: self.parentVC)
            
        }
    }

}
