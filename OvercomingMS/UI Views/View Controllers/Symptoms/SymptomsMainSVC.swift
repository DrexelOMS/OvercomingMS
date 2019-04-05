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
        cell.noteLabel.text = note.Note
        cell.timeLabel.text = OMSDateAccessor.getDateTime(date: savedNotes.getTodaysNotes()![indexPath.row].DateCreated)
        
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)];
        let myString = NSMutableAttributedString(string: "1 2 3 4 5", attributes: attributedStringColor)
        
        let index = note.SymptomsRating - 1
        let myRange = NSRange(location: index * 2 , length: 1)
        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: myRange)
        myString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: cell.ratingLabel.font.pointSize), range: myRange)
        
        let kerning = 5
        let range = NSMakeRange(0, myString.length)
        myString.addAttribute(NSAttributedString.Key.kern, value: NSNumber(value: kerning), range: range)
        
        cell.ratingLabel.attributedText = myString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentVC.pushSubView(newSubView: NoteReviewSVC(noteItem: savedNotes.getTodaysNotes()![indexPath.row]))
    }
    
    func addButtonPressed() {
        savedNotes.addNote(note: "TestNote", symptomsRating: 1, dateCreated: Date())
    }
    
    func listButtonPressed() {
        print("listPressed")
    }
    
}
