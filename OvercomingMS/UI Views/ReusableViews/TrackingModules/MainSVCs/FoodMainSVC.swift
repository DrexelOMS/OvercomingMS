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
        self.parentVC.pushSubView(newSubView: FoodSelectedSVC(unknown: true))
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        controller.dismiss(animated: true) {
            //actually initialize the food object. swift is dumb
            var foodinfo: Food = Food(id: "",name: "",categories: "",satfats: 0,ingredients: "")
            print("Bring up FoodSelectionSVC with barcode: \(code)")
            let barcodeSearch = "https://world.openfoodfacts.org/api/v0/product/"+code+".json"
            
            let eurl = barcodeSearch.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            let url = NSURL(string: eurl ?? "")
            
            //fetching the data from the url
            URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    
                    //printing the json in console
                    //print(jsonObj!.value(forKey: "products")!)
                    
                    //getting the product tag array from json and converting it to NSArray
                    if let foodArray = jsonObj!.value(forKey: "product") as? NSArray {
                        //looping through all the elements
                        for food in foodArray{
                            
                            //converting the element to a dictionary
                            if let foodDict = food as? NSDictionary {
                                let satfat : Int = 0;
                                var categories : String = ""
                                var id : String = ""
                                var ingrdientsList = ""
                                
                                if let types = foodDict.value(forKey: "categories") {
                                    categories=types as! String;
                                }
                                if let types = foodDict.value(forKey: "ingredients_text") {
                                    ingrdientsList=types as! String;
                                }
                                if let ID = foodDict.value(forKey: "_id") {
                                    id=ID as! String;
                                }
                                //not sure how to get this
                                //                            if let nutrientArray = foodDict.value(forKey: "nutriments") as! NSArray{
                                //                                for nutrient in nutrientArray{
                                //                                    if let nutrientDict = nutrient as? NSDictionary {
                                //                                        if let sf = nutrientDict.value(forKey: "saturated-fat_serving") {
                                //                                        satfat = sf as! Int
                                //                                            print(sf);
                                //                                        }
                                //                                    }
                                //                                }
                                //                            }
                                //getting the name from the dictionary
                                if let name = foodDict.value(forKey: "product_name") {
                                    let fooditem = Food(id:id,name:(name as! String), categories: categories, satfats: satfat, ingredients: ingrdientsList)
                                    //print(name as! String + ": " + categories + "\n")
                                    //adding the name to the array
                                    foodinfo = fooditem
                                }
                                
                            }
                        }
                    }
                    
                    OperationQueue.main.addOperation({
                        //calling another function after fetching the json
                        // push unknown if we're unbale to get any info from the barcode
                        if foodinfo.Ingredients.count<1 && foodinfo.Categories.count<1{
                            self.parentVC.pushSubView(newSubView: FoodSelectedSVC(unknown: true))
                        }
                        
                        else if(foodinfo.isFoodGood(food: foodinfo)==RecommendedLevel.Good){
                            self.parentVC.pushSubView(newSubView: FoodSelectedSVC(ingredients:[""], types:[""]))
                        }
                        else if(foodinfo.isFoodGood(food: foodinfo)==RecommendedLevel.Bad){
                            var badingredients = [""]
                            var badTypes = [""]
                            for str in foodinfo.Ingredients.components(separatedBy: ","){
                                for phrases in foodinfo.getVeganPhrases(){
                                    if String(str).lowercased().contains(phrases){
                                        badingredients.append(String(str))
                                    }
                                }
                            }
                            for str in foodinfo.Categories.components(separatedBy: ","){
                                if foodinfo.checkType(type: String(str)) == RecommendedLevel.Bad{
                                    badTypes.append(String(str))
                                }
                            }
                            self.parentVC.pushSubView(newSubView: FoodSelectedSVC(ingredients:badingredients, types:badTypes))
                        }
                        // push unknown if we don't get either good or bad back from the call
                        else
                        {
                            self.parentVC.pushSubView(newSubView: FoodSelectedSVC(unknown: true))
                        }
                        })
                }
            }).resume()
            //TODO: use an api accessor class to get the list of ingredients/type for the given barcode number
            // Note if this fails to find  a food for the barcode, it should pass the unknown mode
            //Use the appropriate FoodSelected Contstructor if you have ingrediants / types, or couldnt find enough info
            
        }
    }

}
