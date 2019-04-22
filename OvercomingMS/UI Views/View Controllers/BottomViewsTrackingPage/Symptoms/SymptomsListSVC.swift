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
    
    var savedNotes: SymptomsList!
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    @IBOutlet weak var tableView: UITableView!
    
    override func customSetup() {
        backButton.backButtonAction = backButtonPressed
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        savedNotes = SymptomsList()
        
        reload()
    }
    
    override func reload() {
        tableView.reloadData()
        
        let count = savedNotes.getCount()
        if count <= 0 {
            tableView.setEmptyView(message: "No notes yet!")
        }
        else {
            tableView.restore()
            //This code is specific to tables that need dynamic cell height and do not need the separator line, like here and medication
            tableView.rowHeight = UITableView.automaticDimension
            tableView.separatorStyle = .none
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedNotes.getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! SymptomsListCell
        
        cell.clear()
        cell.dateLabel.text = savedNotes.getTitleForIndex(index: indexPath.row)
        
        for note in savedNotes.getNotesForIndex(index: indexPath.row) {
            let noteSVC = NoteSVC()
            noteSVC.setNote(note: note)
            cell.addToMiddle(view: noteSVC)
        }

        return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        parentVC.pushSubView(newSubView: NoteReviewSVC(noteItem: savedNotes![indexPath.row]))
//    }

    func backButtonPressed(){
        parentVC.popSubView()
    }

}
