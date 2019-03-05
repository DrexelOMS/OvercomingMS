//
//  SymptomsMainSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SymptomsMainSVC: SlidingAbstractSVC, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    override var nibName: String {
        get {
            return "SymptomsMainSVC"
        }
    }
    
    let defaultCellName = "NoteCell"
    
    let savedNotes = SymptomsNoteDBS()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var plusButtonView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func customSetup() {
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(plusButtonPressed(gesture: )))
        //plusButtonView.addGestureRecognizer(tapGesture)
        
        textField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        reload()
    }
    
    override func reload() {
        tableView.reloadData()
        //configureTableView()
    }
    
//    @objc func plusButtonPressed(gesture: UITapGestureRecognizer) {
//        parentVC.pushSubView(newSubView: NoteReviewSVC())
//    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedNotes.getTodaysNotes()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! NoteCell
        
        cell.noteLabel.text = savedNotes.getTodaysNotes()![indexPath.row].Note
        cell.timeLabel.text = OMSDateAccessor.getDateTime(date: savedNotes.getTodaysNotes()![indexPath.row].DateCreated)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentVC.pushSubView(newSubView: NoteReviewSVC(noteItem: savedNotes.getTodaysNotes()![indexPath.row]))
    }

    func textFieldShouldReturn(_ SearchTextField: UITextField) -> Bool {
        endEditing(true)
        if let text = textField.text {
            if text != "" {
                savedNotes.addNote(note: text, dateCreated: Date())
                reload()
            }
        }
        return true
    }
    
}
