//
//  FoodRejectedSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class FoodRejectedSVC: CustomView, UITableViewDelegate, UITableViewDataSource {
    
    override var nibName: String {
        get {
            return "FoodRejectedSVC"
        }
    }
    
    let cellName = "BadIngredientsCell"
    
    convenience init(_badLabels: [String]) {
        self.init()
        
        badLabels = _badLabels
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }
    
    var badLabels: [String]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func customSetup() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return badLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! BadIngredientsCell
        
        cell.label.text = badLabels[indexPath.row]
        
        return cell
    }
    
}
