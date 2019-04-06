//
//  SymptomsListSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/6/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SymptomsListSVC : SlidingAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    override var nibName: String {
        get {
            return "SymptomsListSVC"
        }
    }
    
    let defaultCellName = "SymptomsListCell"
    
    let savedNotes = SymptomsNoteDBS()
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    @IBOutlet weak var tableView: UITableView!
    
    override func customSetup() {
        backButton.backButtonAction = backButtonPressed
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        reload()
    }
    
    override func reload() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedNotes.getTodaysNotes()?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! SymptomsListCell
        
        cell.clear()
        cell.dateLabel.text = "Today"
        
        if let notes = savedNotes.getTodaysNotes() {
            for i in notes {
                let noteSVC = NoteSVC()
                noteSVC.setNote(note: i)
                cell.addToMiddle(view: noteSVC)
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentVC.pushSubView(newSubView: NoteReviewSVC(noteItem: savedNotes.getTodaysNotes()![indexPath.row]))
    }

    func backButtonPressed(){
        parentVC.popSubView()
    }

}
