//
//  MeditationTimerSetupSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class GuidededMeditationTimerSetupSVC: MeditationTimerSetupAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    let defaultCellName = "TitleTimeOverTextCell"
    
    let titleArray: [String] = [
        "Ocean",
        "Forest"
    ]
    let lengthArray: [Int] = [
        15,
        20,
    ]
    let descriptionArray: [String] = [
        "Lorem ipsum uno",
        "Lorem ipsum duo"
    ]
    
    
    override func customSetup() {
        defaultMainView.removeFromSuperview()
        mainLabel.text = "Select a guided meditation:"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        
        mainViewContainer.addSubview(tableView)
        tableView.backgroundColor = UIColor.clear
        constrain(tableView, mainViewContainer) { (view, superView) in
            view.top == superView.top
            view.right == superView.right
            view.bottom == superView.bottom
            view.left == superView.left
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! TitleTimeOverTextCell
        
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.timeLabel.text = "\(lengthArray[indexPath.row]) min."
        
        return cell;
    }
}
