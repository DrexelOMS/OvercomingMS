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
    @IBOutlet weak var backConfirmButtons: BackConfirmButtonsSVC!
    
    convenience init(noteItem: SymptomsNoteDBT) {
        self.init()
        
        editingNote = noteItem
        noteLabel.text = editingNote.Note
        timeLabel.text = OMSDateAccessor.getDateTime(date: editingNote.DateCreated)
    }
    
    override func customSetup() {
        
    }
    
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        deleteCircleButton.buttonAction = deletePressed
        backConfirmButtons.leftButtonAction = backPressed
        backConfirmButtons.rightButtonAction = backPressed
    }
    
    override func updateColors() {
        deleteCircleButton.colorTheme = parentVC.theme
        backConfirmButtons.colorTheme = parentVC.theme
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
