//
//  ViewController.swift
//  OvercomingMS
//
//  Created by Vince on 1/3/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Alamofire

class DietViewController: UIViewController {
    
    @IBOutlet weak var foodListTextView: UITextView!
    
    private var foodName = ""
    private var ndbno = ""
    
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
        var foodName = "Salmon"
        Alamofire.request(foodListUrlPart1 + foodName + foodListUrlPart2).responseJSON { (response) in
            
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(String(describing: response.result))")
            
            if let json = response.result.value {
                self.foodListTextView.text = "\(json)"
            }
            
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

