//
//  OutsideSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class OutsideSVC: SlidingAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    override var nibName: String {
        get {
            return "OutsideSVC"
        }
    }
    
    let outideDescriptions = ["one","two","three"]
    
    let defaultCellName = "OutsideCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    override func customSetup() {
        backButton.backButtonAction = backButtonPressed
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    func backButtonPressed() {
        parentVC.popSubView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outideDescriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! OutsideCell
        
        return cell
    }
    
}
