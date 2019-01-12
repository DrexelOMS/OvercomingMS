//
//  ViewController.swift
//  OvercomingMS
//
//  Created by Vince on 1/3/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DietViewController: UIViewController {
    
    @IBOutlet weak var foodListTextView: UITextView!
    
    var foodName = ""
    var ndbno = ""
    
    var foodListUrlPart1 = "https://api.nal.usda.gov/ndb/search/?format=json&q="
    var foodListUrlPart2 = "&max=25&offset=0&api_key=vhuS0ESO8hNsZ4JB3vpRc1ibIzDqbivrU8SZDCi3";
    
    var nutrientsUrlPart1 = "https://api.nal.usda.gov/ndb/V2/reports?ndbno="
    var nutrientsUrlPart2 = "&type=f&format=json&api_key=vhuS0ESO8hNsZ4JB3vpRc1ibIzDqbivrU8SZDCi3";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        foodListTextView.text = ""
    }
    
    @IBAction func TestButton(_ sender: UIButton) {
        
        let foodName = "Salmon"
        Alamofire.request(foodListUrlPart1 + foodName + foodListUrlPart2).responseJSON { (response) in
            
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(String(describing: response.result))")
            
            if response.result.isSuccess {
                print("Success! Got the data")
                
                let foodJSON : JSON = JSON(response.result.value!)
                //print(foodJSON.rawString() ?? "")
                
                self.foodListTextView.text = ""
                let foodItems = self.processFoodItems(json: foodJSON)
                print(foodItems)
                for name in foodItems {
                    self.foodListTextView.text += name
                }
                
            }
            else{
                print("Error: \(String(describing: response.result.error))")
                self.foodListTextView.text = "Connection Issues"
            }
            
        }
    }
    
    func processFoodItems(json : JSON) -> [String] {
        
        var stringArray : [String]
        
        stringArray = json["list"]["item"].arrayValue.map({$0["name"].stringValue})
        
        return stringArray
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

