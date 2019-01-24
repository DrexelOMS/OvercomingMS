////
////  TestUpdateTrackingViewController.swift
////  OvercomingMS
////
////  Created by Vincent Finn on 1/20/19.
////  Copyright © 2019 DrexelOMS. All rights reserved.
////
//
//import UIKit
//import RealmSwift
//
//class TestUpdateTrackingViewController: UIViewController, UITextFieldDelegate{
//    
//    @IBOutlet weak var dietTextField: UITextField!
//    
//    
//    let realm = try! Realm()
//    
//    var selectedDay : TrackingDay? {
//        didSet{
//            //loadItems()
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        dietTextField.delegate = self
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        
//        if textField.tag == 0, let value = textField.text {
//            dietEntry(value: value)
//        }
//        
//        return true
//    }
//    
//
//    //TODO: in the future consider using tags for IBActions like these
//
//    func dietEntry(value : String) {
//        print("try writing data: " + value)
//        writeDietData(value: Int(value) ?? 0)
//    }
//    
//    @IBAction func excerciseTextField(_ sender: UITextField) {
//    }
//    
//    @IBAction func vitaminDTextField(_ sender: UITextField) {
//    }
//    
//    func writeDietData(value : Int){
//        if let currentDay = self.selectedDay {
//            do {
//                try self.realm.write {
//                    let foodStats = FoodStats()
//                    foodStats.foodOmega3Count = value;
//                    currentDay.dietStats.append(foodStats)
//                }
//            } catch {
//                print("Error saving new items, \(error)")
//            }
//        }
//    }
//    
//    
//    @IBAction func backButtonPressed(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
//}
