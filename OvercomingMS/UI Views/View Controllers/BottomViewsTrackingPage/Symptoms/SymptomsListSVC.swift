//
//  SymptomsListSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/6/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

struct SymptomsSection : Comparable {
    
    static func < (lhs: SymptomsSection, rhs: SymptomsSection) -> Bool {
        return OMSDateAccessor.getFullDate(date: lhs.Date) < OMSDateAccessor.getFullDate(date: rhs.Date)
    }
    
    static func == (lhs: SymptomsSection, rhs: SymptomsSection) -> Bool {
        return lhs.Date == rhs.Date
    }
    
    var Date : String
    var notes : [SymptomsNoteDBT]
}

class SymptomsListSVC : SlidingAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    override var nibName: String {
        get {
            return "SymptomsListSVC"
        }
    }
    
    let defaultCellName = "NoteCell"
    
    var sections = [SymptomsSection]()
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topLabel: UILabel!
    
    override func customSetup() {
        backButton.backButtonAction = backButtonPressed
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        tableView.register(SymptomsTableHeader.self, forHeaderFooterViewReuseIdentifier: SymptomsTableHeader.reuseIdentifer)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        sections = SymptomsList().getSections()
        
        reload()
    }
    
    override func updateColors() {
        backButton.colorTheme = parentVC.theme
    }
    
    override func reload() {
        tableView.reloadData()
        
        let count = sections.count
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SymptomsTableHeader.reuseIdentifer) as! SymptomsTableHeader
        
        var date = ""
        if sections[section].Date == OMSDateAccessor().todaysDate {
           date = "Today"
        }
        else if sections[section].Date == OMSDateAccessor.getFormatedDate(date: OMSDateAccessor().todaysFullDate.addingTimeInterval(-24*60*60)){
            date = "Yesterday"
        }
        else {
            date = OMSDateAccessor.getStyledDate(date: sections[section].Date)
        }
        
        header.customLabel.text = date

        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! NoteCell
        
        let section = sections[indexPath.section]
        let note = section.notes[indexPath.row]
        cell.noteSVC.setNote(note: note)
        cell.noteSVC.theme = parentVC.theme

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let note = section.notes[indexPath.row]
        parentVC.pushSubView(newSubView: NoteReviewSVC(noteItem: note))
    }

    func backButtonPressed(){
        parentVC.popSubView()
    }
    
    override func layoutSubviews(){
        DispatchQueue.main.async {
            var rate = 1 - ((896 - UIScreen.main.bounds.height)) / 328
            rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
            
            let bigFontSize = 20  + (8) * rate
            
            self.topLabel.font = UIFont(name: self.topLabel!.font.fontName, size: bigFontSize)
        }
    }

}
