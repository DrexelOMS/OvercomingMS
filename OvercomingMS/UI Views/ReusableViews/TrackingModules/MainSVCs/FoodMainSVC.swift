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
        parentVC.pushSubView(newSubView: FoodSearchSVC())
    }
    
    func recipesButtonPressed() {
        print("Pressed Recipes")
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
        self.parentVC.pushSubView(newSubView: FoodSelectedSVC(unknown: true))
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        controller.dismiss(animated: true) {
            print("Bring up FoodSelectionSVC with barcode: \(code)")
        
            //TODO: use an api accessor class to get the list of ingredients/type for the given barcode number
            // Note if this fails to find  a food for the barcode, it should pass the unknown mode
            //Use the appropriate FoodSelected Contstructor if you have ingrediants / types, or couldnt find enough info
            self.parentVC.pushSubView(newSubView: FoodSelectedSVC(unknown: true))
        }
    }

}
