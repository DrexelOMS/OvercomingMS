//
//  MedicationCell.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/24/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MedicationItemSVC : CustomView {
    
    override var nibName: String {
        get {
            return "MedicationItemSVC"
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var doneCheckButton: DoneCheckButton!
    
    var parentVC : SlidingStackVC!
    let savedMedications = SavedMedicationDBS()
    
    var item: SavedMedicationDBT!
    {
        didSet {
            updateStyle()
        }
    }
    
    override func customSetup() {
        self.contentView?.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewPressed(tapGestureRecognizer: )))
        self.contentView?.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        doneCheckButton.toggle()
        if(doneCheckButton.IsDone){
            SavedMedicationDBS().addTakenMedication(item: item)
        }
        else {
            SavedMedicationDBS().removeTakenMedication(item: item)
        }
        updateStyle()
        parentVC.reload()
    }
    
    func updateStyle() {
        nameLabel.text = item.MedicationName
        amountLabel.text = "\(item.MedicationNote)"
        doneCheckButton.IsDone = savedMedications.wasTaken(item: item)
        doneCheckButton.isUserInteractionEnabled = savedMedications.isTrackedToday(item: item)
        
        if doneCheckButton.IsDone {
            nameLabel.textColor = UIColor.lightGray
            amountLabel.textColor = UIColor.lightGray
            let attrString = NSAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            nameLabel.attributedText = attrString

        }
        else {
            nameLabel.textColor = UIColor.black
            amountLabel.textColor = UIColor.black
            let attrString = NSAttributedString(string: nameLabel.text!)
            nameLabel.attributedText = attrString
        }
        
        if(!doneCheckButton.isUserInteractionEnabled){
            backgroundColor = UIColor.lightGray
            backgroundColor?.withAlphaComponent(0.5)
        }
        else {
            backgroundColor = UIColor.clear
            backgroundColor?.withAlphaComponent(1.0)
        }
    }
    
    @objc private func viewPressed(tapGestureRecognizer: UITapGestureRecognizer) {
        let medicationItemSVC = MedicationSelectedItemSVC()
        medicationItemSVC.savedMedicationItem = item
        medicationItemSVC.parentVC = parentVC
        parentVC.pushSubView(newSubView: medicationItemSVC)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        contentView?.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        contentView?.backgroundColor = UIColor.gray
    }
    
}

