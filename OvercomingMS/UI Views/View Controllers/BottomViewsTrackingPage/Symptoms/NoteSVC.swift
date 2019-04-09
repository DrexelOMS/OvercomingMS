//
//  NoteSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/6/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class NoteSVC: CustomView {
    
    override var nibName: String {
        get {
            return "NoteSVC"
        }
    }
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func customSetup() {
        
    }
    
    func setNote(note: SymptomsNoteDBT){
        noteLabel.text = note.Note
        timeLabel.text = OMSDateAccessor.getDateTime(date: note.DateCreated)
        
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)];
        let myString = NSMutableAttributedString(string: "1 2 3 4 5", attributes: attributedStringColor)
        
        let index = note.SymptomsRating - 1
        let myRange = NSRange(location: index * 2 , length: 1)
        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: myRange)
        myString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: ratingLabel.font.pointSize), range: myRange)
        
        let kerning = 5
        let range = NSMakeRange(0, myString.length)
        myString.addAttribute(NSAttributedString.Key.kern, value: NSNumber(value: kerning), range: range)
        
        ratingLabel.attributedText = myString
    }
}
