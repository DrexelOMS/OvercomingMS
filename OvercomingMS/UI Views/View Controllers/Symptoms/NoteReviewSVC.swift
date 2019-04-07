//
//  NoteReviewSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class NoteReviewSVC: SlidingAbstractSVC, ToolBarDelegate, UITextViewDelegate, TFIDelegate {
    
    override var nibName: String {
        get {
            return "NoteReviewSVC"
        }
    }
    
    var editingNote: SymptomsNoteDBT!
    
    @IBOutlet weak var noteView: RoundedBoxShadowsTemplate!
    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var deleteCircleButton: DeleteCircleButton!
    @IBOutlet weak var backConfirmButtons: BackConfirmButtonsSVC!
    //160 + 0 is the default 
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    let toolbar = ToolBar()
    var symptomsVC: SymptomsVC!
    
    var selectedTime : Date? {
        get {
            return timeTFI.selectedStartTime
        }
        set {
            timeTFI.selectedStartTime = newValue
        }
    }
    
    //must be int between 1-5
    var selectedSeverity : String? {
        get {
            return severityTFI.selectedType
        }
        set {
            severityTFI.selectedType =  newValue
        }
    }
    
    @IBOutlet weak var timeTFI: DateTimeTFI!
    @IBOutlet weak var severityTFI: SeverityTFI!
    
    convenience init(noteItem: SymptomsNoteDBT) {
        self.init()
        
        editingNote = noteItem
        noteTextField.text = noteItem.Note
        selectedTime = noteItem.DateCreated
        selectedSeverity = String(noteItem.SymptomsRating)
        //timeLabel.text = OMSDateAccessor.getDateTime(date: editingNote.DateCreated)
    }
    
    override func customSetup() {
        toolbar.delegate = self
        noteTextField.delegate = self
        
        noteTextField.inputAccessoryView = toolbar.getToolBar()

    }
    
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        symptomsVC = parentVC as? SymptomsVC
        
        deleteCircleButton.buttonAction = deletePressed
        backConfirmButtons.leftButtonAction = backPressed
        backConfirmButtons.rightButtonAction = confirmPressed
        
        timeTFI.parentVC = parentVC
        timeTFI.tfiDelegate = self
        severityTFI.parentVC = parentVC
        severityTFI.tfiDelegate = self
        
        if editingNote == nil {
            noteTextField.text = "Tap to edit"
            noteTextField.textColor = UIColor.lightGray
        }
        
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
        parentVC.popSubView()
    }
    
    func confirmPressed() {
        if let note = noteTextField.text, let rating = Int(selectedSeverity!), let date = selectedTime {
            if note == "" {
                return
            }
            
            let savedNotes = SymptomsNoteDBS()
            if let oldNote = editingNote {
                let newItem = SymptomsNoteDBT()
                newItem.DateCreated = date
                newItem.Note = note
                newItem.SymptomsRating = rating
                
                savedNotes.editNote(oldItem: oldNote, newItem: newItem)
            }
            else {
                savedNotes.addNote(note: note, symptomsRating: rating, dateCreated: date)
            }
            
             parentVC.popSubView()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        symptomsVC.toggleTopImage(isHidden: true)
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Tap to edit"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func donePressed() {
        parentVC.view.endEditing(true)
        symptomsVC.toggleTopImage(isHidden: false)
    }
    
    func cancelPressed() {
        parentVC.view.endEditing(true)
        symptomsVC.toggleTopImage(isHidden: false)
    }
    
    func OnTFIOpened(tfi: TFIAbstract, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions, keyboardHeight: CGFloat) {
        noteView.isHidden = true
        if tfi == severityTFI {
            timeTFI.isHidden = true
        }
        else {
            severityTFI.isHidden = true
        }
        bottomConstraint.constant = keyboardHeight - 160
//        symptomsVC.toggleTopImage(isHidden: true)
    }
    
    func OnTFIClosed(tfi: TFIAbstract, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions, keyboardHeight: CGFloat) {
        noteView.isHidden = false
        timeTFI.isHidden = false
        severityTFI.isHidden = false
        
        bottomConstraint.constant = 0
        symptomsVC.toggleTopImage(isHidden: false)
    }
    
}
