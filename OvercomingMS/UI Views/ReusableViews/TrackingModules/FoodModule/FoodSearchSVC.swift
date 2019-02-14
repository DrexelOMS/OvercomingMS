//
//  FoodSearchSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/13/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class FoodSearchSVC : SlidingAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    let foodCellName = "FoodSearchCell"
    
    override var nibName: String {
        get {
            return "FoodSearchSVC"
        }
    }
    
    override func customSetup() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: foodCellName, bundle: nil), forCellReuseIdentifier: foodCellName)
    
    }
    
    override func updateColors() {
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        parentVC.popSubView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodCellName, for: indexPath) as! FoodSearchCell
        
        cell.nameLabel.text = "Food"
        cell.descriptionLabel.text = "Trader Joe's"
        cell.setRecommendedStatus(isGood: true)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
}
