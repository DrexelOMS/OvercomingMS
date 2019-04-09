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
    @IBOutlet weak var addButton: AddCircleButton!
    @IBOutlet weak var listButton: ListCircleButton!
    
    
    override func customSetup() {
        listButton.isHidden = true
        
        addButton.buttonAction = addButtonPressed
        listButton.buttonAction = listButtonPressed
        
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
