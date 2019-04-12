//
//  NoteReviewSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class NoteReviewSVC: SlidingAbstractSVC, ToolBarDelegate, UITextViewDelegate, TFIDelegate {
    
    override var nibName: String {
        get {
            return "NoteReviewSVC"
        }
    }
    
    var editingNote: SymptomsNoteDBT!
    
    @IBOutlet weak var noteView: RoundedBoxShadowsTemplate!
    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var deleteCircleButton: CircleButtonSVC!
    @IBOutlet weak var backConfirmButtons: BackConfirmButtonsSVC!
    //160 + 0 is the default 
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    let toolbar = ToolBar()
    var symptomsVC: TopImageSlidingStackVC!
    
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
    
    @IBOutlet weak var stackView: UIStackView!
    var severityTFI = TypeTFIFactory.SeverityTypeTFI()
    var timeTFI = DateTimeTFI()
    let placeholderText = "Tap to edit"
    
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

        stackView.addArrangedSubview(timeTFI)
        stackView.addArrangedSubview(severityTFI)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        constrain(timeTFI) { (view) in
            view.height == 51
        }
        constrain(severityTFI) { (view) in
            view.height == 51
        }
    }
    
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        symptomsVC = parentVC as? TopImageSlidingStackVC
        
        deleteCircleButton.buttonAction = deletePressed
        backConfirmButtons.leftButtonAction = backPressed
        backConfirmButtons.rightButtonAction = confirmPressed
        
        timeTFI.parentVC = parentVC
        timeTFI.tfiDelegate = self
        severityTFI.parentVC = parentVC
        severityTFI.tfiDelegate = self
        
        if editingNote == nil {
            noteTextField.text = placeholderText
            noteTextField.textColor = UIColor.lightGray
            deleteCircleButton.isHidden = true
        }
        
    }
    
    override func updateColors() {
        deleteCircleButton.colorTheme = parentVC.theme
        backConfirmButtons.colorTheme = parentVC.theme
    }
    
    override func reload() {
        
    }
    
    func deletePressed() {
        let deletePage = ConfirmationFactory.DeleteConfirmation()
        deletePage.methodToRunOnConfirm = deleteItem
        deletePage.resetToDefault = true
        parentVC.pushSubView(newSubView: deletePage)
    }
    
    func deleteItem() {
        SymptomsNoteDBS().deleteNote(item: editingNote)
    }
    
    func backPressed() {
        parentVC.popSubView()
    }
    
    func confirmPressed() {
        if let note = noteTextField.text, let rating = selectedSeverity, let date = selectedTime {
            if note == "" || note == placeholderText {
                return
            }
            if let ratingInt = Int(rating) {
                let savedNotes = SymptomsNoteDBS()
                if let oldNote = editingNote {
                    let newItem = SymptomsNoteDBT()
                    newItem.DateCreated = date
                    newItem.Note = note
                    newItem.SymptomsRating = ratingInt
                    
                    savedNotes.editNote(oldItem: oldNote, newItem: newItem)
                }
                else {
                    savedNotes.addNote(note: note, symptomsRating: ratingInt, dateCreated: date)
                }
                
                 parentVC.popSubView()
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        let averageKeyboardHeight = 216 + 60
        //Yes I know, these are the 4 height constraints of the things below the note
        var botHeight = 60 + 100 + 51 + 51
        if editingNote == nil {
            botHeight = 60 + 51 + 51
        }
        
        bottomConstraint.constant = CGFloat(averageKeyboardHeight - botHeight)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Tap to edit"
            textView.textColor = UIColor.lightGray
        }
        bottomConstraint.constant = 0
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
        var botHeight = 160
        if editingNote == nil {
            botHeight = 60
        }
        bottomConstraint.constant = keyboardHeight - CGFloat(botHeight)
//        symptomsVC.toggleTopImage(isHidden: true)
    }
    
    func OnTFIClosed(tfi: TFIAbstract, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions, keyboardHeight: CGFloat) {
        noteView.isHidden = false
        timeTFI.isHidden = false
        severityTFI.isHidden = false
        
        bottomConstraint.constant = 0
//        symptomsVC.toggleTopImage(isHidden: false)
    }
    
}
