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
import TOWebViewController

class FoodMainSVC: SlidingAbstractSVC, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    
    override var nibName: String {
        get {
            return "FoodMainSVC"
        }
    }
    
    let button1 = CircleButtonFactory.SearchButton()
    let button2 = CircleButtonFactory.RecipesButton()
    let button3 = CircleButtonFactory.ScanButton()
    let button4 = CircleButtonFactory.SavedButton()
    
    let barcodeScannerVC = BarcodeScannerViewController()
    let foodinfo: Food = Food()
    var capturedCode: String!
    
    
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var imageContainer: RoundedBoxShadowsTemplate!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingArea: UIView!
    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var ratingView: FiveScaleRatingButtonsSVC!
    
    override func customSetup() {
        imageContainer.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imagePressed(tapGestureRecognizer: )))
        imageContainer.addGestureRecognizer(tapGesture)
    }

    @objc func imagePressed(tapGestureRecognizer: UITapGestureRecognizer){
        let webViewController = TOWebViewController(urlString: "https://overcomingms.org/recovery-program/diet")
        let navigation = UINavigationController.init(rootViewController: webViewController)
        
        parentVC.present(navigation, animated: true, completion: nil)
    }
    
    //must be called by 
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        button1.buttonAction = searchButtonPressed
        button2.buttonAction = recipesButtonPressed
        button3.buttonAction = scanButtonPressed
        button4.buttonAction = savedButtonPressed
        
        buttonStackView.addArrangedSubview(button1)
        buttonStackView.addArrangedSubview(button2)
        //buttonStackView.addArrangedSubview(button4)
        buttonStackView.addArrangedSubview(button3)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func searchButtonPressed() {
        parentVC.pushSubView(newSubView: FoodSearchSVC())
    }
    
    func recipesButtonPressed() {
        let webViewController = TOWebViewController(urlString: "https://overcomingms.org/recovery-program/recipes/")
        let navigation = UINavigationController.init(rootViewController: webViewController)

        parentVC.present(navigation, animated: true, completion: nil)
        
    }
    
    func scanButtonPressed() {
        barcodeScannerVC.codeDelegate = self
        barcodeScannerVC.errorDelegate = self
        barcodeScannerVC.dismissalDelegate = self
        
        parentVC.present(barcodeScannerVC, animated: true, completion: nil)
    }
    
    func savedButtonPressed() {}
    
    override func updateColors() {
        button1.colorTheme = parentVC.theme
        button2.colorTheme = parentVC.theme
        button3.colorTheme = parentVC.theme
        button4.colorTheme = parentVC.theme
        ratingView.colorTheme = parentVC.theme
        ratingView.reload()
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
        //actually initialize the food object. swift is dumb
//        foodinfo.getFoodFromID(id: "3181232127608", parentVC: self.parentVC)
///
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        capturedCode = code
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func layoutSubviews() {
        DispatchQueue.main.async {
            print(self.ratingArea.frame.height)
            print(self.labelContainer.frame.height)
            print(self.ratingView.frame.height)
            
            var rate = 1 - ((80 - self.labelContainer.frame.height)) / 14
            rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
            
            let fontSize = 14  + (6) * rate
            self.ratingLabel.font  = UIFont(name: self.ratingLabel!.font.fontName, size: fontSize)
        }
    }

}
