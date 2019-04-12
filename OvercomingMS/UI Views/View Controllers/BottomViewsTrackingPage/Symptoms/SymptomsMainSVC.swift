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
    
    let savedNotes = SymptomsNoteDBS()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: CircleButtonSVC!
    @IBOutlet weak var listButton: CircleButtonSVC!
    
    
    override func customSetup() {
        listButton.isHidden = true
        
        addButton.buttonAction = addButtonPressed
        listButton.buttonAction = listButtonPressed
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        
        reload()
    }
    
    override func reload() {
        tableView.reloadData()
        
        let count = savedNotes.getTodaysNotes()?.count ?? 0
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
        return savedNotes.getTodaysNotes()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! NoteCell
        
        let note = savedNotes.getTodaysNotes()![indexPath.row]
        cell.noteSVC.setNote(note: note)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentVC.pushSubView(newSubView: NoteReviewSVC(noteItem: savedNotes.getTodaysNotes()![indexPath.row]))
    }
    
    func addButtonPressed() {
        parentVC.pushSubView(newSubView: NoteReviewSVC())
    }
    
    func listButtonPressed() {
        parentVC.pushSubView(newSubView: SymptomsListSVC())
    }
    
}
