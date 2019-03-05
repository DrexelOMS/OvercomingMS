//
//  NoteReviewSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class NoteReviewSVC: SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "NoteReviewSVC"
        }
    }
    
    var editingNote: SymptomsNoteDBT!
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deleteCircleButton: DeleteCircleButton!
    @IBOutlet weak var backConfirmButton: BackConfirmButtonsSVC!
    
    convenience init(noteItem: SymptomsNoteDBT) {
        self.init()
        
        editingNote = noteItem
        noteLabel.text = editingNote.Note
        timeLabel.text = OMSDateAccessor.getDateTime(date: editingNote.DateCreated)
    }
    
    override func customSetup() {
        
    }
    
    override func initialize(parentVC: SwipeDownCloseViewController) {
        super.initialize(parentVC: parentVC)
        
        deleteCircleButton.colorTheme = parentVC.theme
        deleteCircleButton.buttonAction = deletePressed
        backConfirmButton.leftButtonAction = backPressed
        backConfirmButton.rightButtonAction = backPressed
    }
    
    override func reload() {
        
    }
    
    func deletePressed() {
        parentVC.pushSubView(newSubView: DeleteConfirmationSVC(methodToRunOnConfirm: deleteItem, resetToDefault: true))
    }
    
    func deleteItem() {
        SymptomsNoteDBS().deleteNote(item: editingNote)
    }
    
    func backPressed() {
        parentVC.resetToDefaultView()
    }
    
}
