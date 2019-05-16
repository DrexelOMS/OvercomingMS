//
//  FoodRejectedSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import TOWebViewController

class FoodRejectedSVC: CustomView, UITableViewDelegate, UITableViewDataSource {
    
    override var nibName: String {
        get {
            return "FoodRejectedSVC"
        }
    }
    
    let cellName = "BadIngredientsCell"
    var parentVC: SlidingStackVC!
    var buttonAction: (() -> ())?
    
    convenience init(_badLabels: [String], seeMoreMethod: @escaping () -> ()) {
        self.init()
        
        buttonAction = seeMoreMethod
        badLabels = _badLabels
        if badLabels[0] == "" {
            badLabels.remove(at: 0)
        }
        
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
        
        print(badLabels[indexPath.row])
        cell.label.text = badLabels[indexPath.row]
        
        return cell
    }
    
    @IBAction func seeMoreButton(_ sender: Any) {
        guard let action = buttonAction else {
            fatalError("no action set")
        }
        action()
    }
    
}
