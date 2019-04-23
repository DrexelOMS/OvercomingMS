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
    var searchCriteria = "";
    var nameArray = [String]()
    
    var foodItemsArray: [Food] = []
    
    override func customSetup() {
        backButton.backButtonAction = backButtonPressed
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: foodCellName, bundle: nil), forCellReuseIdentifier: foodCellName)
        
        searchBarButton.SearchButton.addTarget(self, action: #selector(getJsonFromUrl), for: .touchUpInside)
        
        do{
            try getJsonFromUrl();
        }
        catch{
        print("There was a problem connecting to the food database. Please check your network connection")
        }
    }
    
    override func updateColors() {
        backButton.colorTheme = parentVC.theme
    }
    
    //this function is fetching the json from URL
    @objc func getJsonFromUrl(){
        //creating a NSURL
        
        searchCriteria = searchBarButton.SearchTextField.text ?? ""
        if(searchCriteria == ""){
            return
        }
        let neurl = URLBeginning+searchCriteria+URLEnd
        let eurl = neurl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = NSURL(string: eurl ?? "")
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            if(data == nil){
                let message = "There was a problem connecting to the food database. Please check your network connection and try again";
                print(message)
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                self.parentVC.present(alert, animated: true, completion: nil)
                return
            }
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                //print(jsonObj!.value(forKey: "products")!)
                
                //getting the products tag array from json and converting it to NSArray
                if let foodArray = jsonObj!.value(forKey: "products") as? NSArray {
                    self.foodItemsArray.removeAll()
                    //looping through all the elements
                    for food in foodArray{
                        
                        //converting the element to a dictionary
                        if let foodDict = food as? NSDictionary {
                            let satfat : Int = 0;
                            var categories : String = ""
                            var id : String = ""
                            var ingrdientsList = ""
                            var brand = ""
                            
                            if let types = foodDict.value(forKey: "categories") {
                                categories=types as! String;
                            }
                            if let types = foodDict.value(forKey: "ingredients_text") {
                                ingrdientsList=types as! String;
                            }
                            if let ID = foodDict.value(forKey: "_id") {
                                id=ID as! String;
                            }
                            if let Brand = foodDict.value(forKey: "brands") {
                                brand=Brand as! String;
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
                                let fooditem = Food(id:id,name:(name as! String), categories: categories, satfats: satfat, ingredients: ingrdientsList, brand:brand)
                                //print(name as! String + ": " + categories + "\n")
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
    
    func checkType(type:String) -> RecommendedLevel{
        if(type.contains("Dairy")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Dairies")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Meat")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Meats")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Fat")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Fats")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Egg")){
            return RecommendedLevel.Caution
        }
        if(type.contains("Eggs")){
            return RecommendedLevel.Caution
        }
        if(type.contains("Cheese")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Poultry")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Poultries")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Beef")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Beefs")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Chicken")){
            return RecommendedLevel.Bad
        }
        if(type.contains("Chickens")){
            return RecommendedLevel.Bad
        }
        return RecommendedLevel.Good
    }
    
    
    override func reload(){
        tableView.reloadData()
        
        
        let count = foodItemsArray.count
        if count <= 0 {
            tableView.setEmptyView(message: "No saved foods yet!")
        }
        else {
            tableView.restore()
        }
        
        tableView.separatorStyle = .none
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
        cell.descriptionLabel.text = ""//food.Id
        cell.setRecommendedStatus(isGood: food.isFoodGood(food: food))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = foodItemsArray[indexPath.row]
        var badingredients = [""]
        var badTypes = [""]
        print(food.isFoodGood(food: food))
        if food.isFoodGood(food: food)==RecommendedLevel.Good{
            parentVC.pushSubView(newSubView: FoodSelectedSVC(food: food, unknown: false))
        }
        else if food.isFoodGood(food: food) == RecommendedLevel.Caution{
            parentVC.pushSubView(newSubView: FoodSelectedSVC(food: food, unknown: true))
        }
        else{
            
            for str in food.Ingredients.components(separatedBy: ","){
                for phrases in Food.nonVeganPhrases{
                    if String(str).lowercased().contains(phrases){
                        var string = str.replacingOccurrences(of: "*", with: "")
                        string = string.replacingOccurrences(of: ")", with: "")
                        string = string.replacingOccurrences(of: "(", with: "")

                        badingredients.append(String(string))
                        break;
                    }
                }
            }
            for str in food.Categories.components(separatedBy: ","){
                if checkType(type: String(str)) == RecommendedLevel.Bad{
                    badTypes.append(String(str))
                }
            }
            
            parentVC.pushSubView(newSubView: FoodSelectedSVC(food:food, ingredients:badingredients, types:badTypes))
        }
    }
}
