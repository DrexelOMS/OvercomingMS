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
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    
    override func customSetup() {
        addButton.buttonAction = addButtonPressed
        listButton.buttonAction = listButtonPressed
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        
        reload()
    }
    
    override func reload() {
        tableView.reloadData()
        
        let count = savedNotes.getTodaysNotes().count
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
        return savedNotes.getTodaysNotes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! NoteCell
        
        let note = savedNotes.getTodaysNotes()[indexPath.row]
        cell.noteSVC.setNote(note: note)
        cell.noteSVC.theme = parentVC.theme
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentVC.pushSubView(newSubView: NoteReviewSVC(noteItem: savedNotes.getTodaysNotes()[indexPath.row]))
    }
    
    func addButtonPressed() {
        parentVC.pushSubView(newSubView: NoteReviewSVC())
    }
    
    func listButtonPressed() {
        parentVC.pushSubView(newSubView: SymptomsListSVC())
    }
    
    override func layoutSubviews() {
        DispatchQueue.main.async {
            var rate = 1 - ((896 -  UIScreen.main.bounds.height)) / 328
            rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
            
            let height = 80 + (20) * rate
            
            self.headerHeightConstraint.constant = height
        }
    }
    
}
