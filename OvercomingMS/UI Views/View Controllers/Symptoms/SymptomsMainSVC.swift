//
//  SymptomsMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SymptomsMainSVC: SlidingAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    override var nibName: String {
        get {
            return "SymptomsMainSVC"
        }
    }
    
    let defaultCellName = "NoteCell"
    
    var testArray = ["word", "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", "word2"]
    
    @IBOutlet weak var plusButtonView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func customSetup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(plusButtonPressed(gesture: )))
        plusButtonView.addGestureRecognizer(tapGesture)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        reload()
    }
    
    override func reload() {
        tableView.reloadData()
        configureTableView()
    }
    
    @objc func plusButtonPressed(gesture: UITapGestureRecognizer) {
        parentVC.pushSubView(newSubView: NoteReviewSVC())
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! NoteCell
        
        cell.noteLabel.text = testArray[indexPath.row]
        
        return cell
    }
}
