////
////  ViewController.swift
////  OvercomingMS
////
////  Created by Vince on 1/3/19.
////  Copyright © 2019 DrexelOMS. All rights reserved.
////
//
//import UIKit
//import Alamofire
//import SwiftyJSON
//
//class DietViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var foodItemTableView: UITableView!
//
//    var foodItemNames : [String] = []
//    var foodItemIds : [String] = []
//
//    var searchFoodEntry = ""
//    var ndbno = ""
//
//    var foodListUrlPart1 = "https://api.nal.usda.gov/ndb/search/?format=json&q="
//    var foodListUrlPart2 = "&max=25&offset=0&api_key=vhuS0ESO8hNsZ4JB3vpRc1ibIzDqbivrU8SZDCi3";
//
//    var nutrientsUrlPart1 = "https://api.nal.usda.gov/ndb/V2/reports?ndbno="
//    var nutrientsUrlPart2 = "&type=f&format=json&api_key=vhuS0ESO8hNsZ4JB3vpRc1ibIzDqbivrU8SZDCi3";
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//        foodItemTableView.delegate = self
//        foodItemTableView.dataSource = self
//    }
//
//    //MARK: Button Presses
//
//    @IBAction func TestButton(_ sender: UIButton) {
//
//        let foodName = "Salmon"
//        Alamofire.request(foodListUrlPart1 + foodName + foodListUrlPart2).responseJSON { (response) in
//
//            if response.result.isSuccess {
//                print("Success! Got the data")
//
//                let foodJSON : JSON = JSON(response.result.value!)
//                self.processFoodItems(json: foodJSON)
//
//                self.foodItemTableView.reloadData()
//            }
//            else{
//                print("Error: \(String(describing: response.result.error))")
//                //TODO: add a way to notify the user that a connection could not be established
//            }
//        }
//    }
//
//    func processFoodItems(json : JSON) {
//        foodItemNames = json["list"]["item"].arrayValue.map({$0["name"].stringValue})
//        foodItemIds = json["list"]["item"].arrayValue.map({$0["ndbno"].stringValue})
//    }
//
//    @IBAction func backButtonPressed(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    //MARK: TableView Delegate Methods
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return foodItemNames.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = foodItemTableView.dequeueReusableCell(withIdentifier: "FoodItemsCell", for: indexPath) as! FoodItemsCell
//        
//        cell.FoodItemNameLabel.text = foodItemNames[indexPath.row]
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        Alamofire.request(nutrientsUrlPart1 + foodItemIds[indexPath.row] + nutrientsUrlPart2).responseJSON {
//            (response) in
//
//            if response.result.isSuccess {
//                print("Success! Got the data")
//
//                let nutrientJSON : JSON = JSON(response.result.value!)
//                let nutritionalData = nutrientJSON.description
//                //self.processNutritionalInfo(json: nutrientJSON)
//
//                let alertMessage = "You have selected item \(self.foodItemIds[indexPath.row]) with this data \(nutritionalData)"
//                let alertController = UIAlertController(title: "Nutrients", message: alertMessage, preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//                alertController.addAction(alertAction)
//                self.present(alertController, animated: true, completion: nil)
//
//            }
//            else{
//                print("Error: \(String(describing: response.result.error))")
//                //TODO: add a way to notify the user that a connection could not be established
//            }
//        }
//    }
//
//    func processNutritionalInfo(json: JSON) {
//        //TODO: should open another view and parse the data appropriately
//    }
//
//}
//
