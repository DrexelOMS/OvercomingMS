//
//  FoodSearchSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

class FoodSearchSVC : SlidingAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarButton: SearchBarButton!
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    let foodCellName = "FoodSearchCell"
    
    override var nibName: String {
        get {
            return "FoodSearchSVC"
        }
    }
    
    let URLBeginning = "https://us.openfoodfacts.org/cgi/search.pl?search_terms=";
    let URLEnd = "&search_simple=1&action=process&json=1";
    var searchCriteria = "Chicken%20Wing";
    var nameArray = [String]()
    
    var foodItemsArray: [Food] = []
    
    override func customSetup() {
        backButton.backButtonAction = backButtonPressed
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: foodCellName, bundle: nil), forCellReuseIdentifier: foodCellName)
        
        searchBarButton.SearchButton.addTarget(self, action: #selector(getJsonFromUrl), for: .touchUpInside)
        
        getJsonFromUrl();
    }
    
    override func updateColors() {
        
    }
    
    //this function is fetching the json from URL
    @objc func getJsonFromUrl(){
        //creating a NSURL
        
        searchCriteria = searchBarButton.SearchTextField.text ?? ""
        if(searchCriteria == ""){
            return
        }
        
        let url = NSURL(string: URLBeginning+searchCriteria+URLEnd)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                //print(jsonObj!.value(forKey: "products")!)
                
                //getting the products tag array from json and converting it to NSArray
                if let foodArray = jsonObj!.value(forKey: "products") as? NSArray {
                    //looping through all the elements
                    for food in foodArray{
                        
                        //converting the element to a dictionary
                        if let foodDict = food as? NSDictionary {
                            var satfat : Int = 0;
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
                                let fooditem = Food(id:id,name:name as! String, categories: categories, satfats: satfat, ingredients: ingrdientsList)
                                print(name as! String + ": " + categories + "\n")
                                //adding the name to the array
                                self.foodItemsArray.append(fooditem);
                                //self.nameArray.append((name as? String)!)
                            }
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    //it will show the names to label
                    //print(self.foodItemsArray);
                    //self.showNames()
                    self.reload()
                })
            }
        }).resume()
    }
    
    func getFoodItems(json : JSON) {
        
    }
    
    func isFoodGood(food : Food) -> RecommendedLevel{
        if food.SatFats>1{
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Dairy")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Dairies")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Meat")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Meats")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Fat")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Fats")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Egg")){
            return RecommendedLevel.Caution
        }
        if(food.Categories.contains("Eggs")){
            return RecommendedLevel.Caution
        }
        if(food.Categories.contains("Cheese")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Poultry")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Poultries")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Beef")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Beefs")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Chicken")){
            return RecommendedLevel.Bad
        }
        if(food.Categories.contains("Chickens")){
            return RecommendedLevel.Bad
        }
        
        for ingredient in Food.nonVeganPhrases{
            if(food.Ingredients.contains(ingredient)){
                return RecommendedLevel.Bad
            }
        }
        
        return RecommendedLevel.Good
    }
    
    
    override func reload(){
        tableView.reloadData()
    }
    
    
    func backButtonPressed() {
        parentVC.popSubView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodCellName, for: indexPath) as! FoodSearchCell
        
        let food = foodItemsArray[indexPath.row]
        
        cell.nameLabel.text = food.Name
        cell.descriptionLabel.text = food.Id
        cell.setRecommendedStatus(isGood: isFoodGood(food: food))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentVC.pushSubView(newSubView: FoodSelectedSVC(stuff: "Stuff"))
    }
    
}
